//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/26.
//

import UIKit
import AVFoundation
import ViewAnimator

class GameController: UIViewController {
    
    var audioFX = AudioFX()
    var prop = Properties()
    var contentLoader = ContentLoader()
    let gameInterface = GameInterface()
    var gameLogic = GameLogic()
    
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = gameInterface.gameView
        
        gameInterface.setupSubviews()
        gameInterface.setupConstraints()
        
        //timer to load and get the width & height properties!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.setupButtons(rows: Properties.rows, columns: Properties.columns)
        }
        
        gameInterface.restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        gameInterface.backToMenuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        gameInterface.quitButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        gameInterface.muteMusicButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
        gameInterface.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("default time: \(defaults.integer(forKey: StatisticsKey.time.rawValue))")
        print("default pairs: \(defaults.integer(forKey: StatisticsKey.pairs.rawValue))")
        print("default flips: \(defaults.integer(forKey: StatisticsKey.flips.rawValue))")
        
        navigationController?.navigationBar.isHidden = true
        //disable gestures:
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //timer to load and get the width & height properties! (cheating)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let widthButtonsView = self.gameInterface.buttonsView.frame.width
            print("ButtonsView width: \(widthButtonsView)")
            //setup time:
            self.gameInterface.timeCounter = self.prop.standardTimeCounter
            //total time for statistics:
            self.prop.totalTime = self.gameInterface.timeCounter
            print("total time: \(self.prop.totalTime)")
            
            self.loadLevel()
        }
        
        //debugging Constraints error message:
//        UserDefaults.standard.set(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        //Background AudioFX:
        DispatchQueue.main.async {
            try? self.audioFX.playBackgroundMusic(file: AudioFileKey.SnowfallButterfiles.rawValue, type: AudioTypeKey.mp3.rawValue)
            if self.prop.mutedGeneral {
                self.audioFX.backgroundMusic?.volume = self.defaults.float(forKey: AudioKey.volumeLevel.rawValue)
            } else {
                self.audioFX.backgroundMusic?.volume = self.defaults.float(forKey: AudioKey.volumeLevel.rawValue)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ViewAnimator:
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 200)
        gameInterface.buttonsView.animate(animations: [fromAnimation], duration: 0.5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //audioFX:
        DispatchQueue.main.async {
            self.audioFX.stopMusic()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameInterface.setGradientBackground()
    }
    
    //MARK: - LoadLevel:
    
    func loadLevel() {
        //reset card counter:
        prop.cardCounter = 0
        
        if prop.gameIsOver {
            gameOver()                                          //test Game Over
        }
        
        gameLogic.setupCards(Properties.cardList2)
    }
    
    //MARK: - nextLevel:
    
    func nextLevel() {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.victory.rawValue, type: AudioTypeKey.wav.rawValue)
        
        //nextLevelLabel animation:
        UIView.animate(withDuration: 0.5, animations:  {
            self.gameInterface.nextLevelLabel.alpha = 1
            self.gameInterface.gameOverLabel.pulsate()
        })
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //remove old subview:
            self.gameInterface.buttonsView.subviews.forEach { $0.removeFromSuperview() }
            
            //invalidateTimer:
            self.prop.timer.invalidate()
            
            self.gameInterface.nextLevelLabel.alpha = 0
            
            Properties.activatedCards.removeAll()
            Properties.activatedButtons.removeAll()
            Properties.cardButtons.removeAll()           //  fixed bug - reset cardButtons array
                        
            //update level:
            if Properties.rows < 5 && Properties.columns < 4 {
                Properties.rows += 1
                Properties.columns += 1
            }
            self.setupButtons(rows: Properties.rows, columns: Properties.columns)
            self.loadLevel()
            
            //reset cards color:
            for card in Properties.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    card.pulsateRemove()
                    card.alpha = 1
                    card.isEnabled = true
                })
            }
        }
    }
    
    //MARK: - GameOver:
    
    func gameOver() {
        //reset timer:
        prop.timer.invalidate()
        //audioFX:
        try? audioFX.playGameStateFX(file: AudioFileKey.gameOver.rawValue, type: AudioTypeKey.wav.rawValue)
        //labels animations:
        UIView.animate(withDuration: 0.5, animations:  {
            self.gameInterface.gameOverLabel.alpha = 1
            self.gameInterface.statisticsView.alpha = 1
            self.gameInterface.backToMenuButton.alpha = 1
            self.gameInterface.restartButton.alpha = 1
            self.gameInterface.gameOverLabel.pulsate()
            self.gameInterface.restartButton.pulsate()
        })
        
        //update statistics UI:
        DispatchQueue.main.async {
            self.gameInterface.statisticsLabel.text = "Your Result: \n Total Time: \(self.prop.totalTime) sec. \n Found Pairs: \(self.gameInterface.pairsCounter) \n Total Flips: \(self.gameInterface.flipsCounter) \n ------------------------------"
            
            self.gameInterface.bestResultLabel.text = "Best result: \n Total Time: \(self.defaults.integer(forKey: StatisticsKey.time.rawValue)) sec. \n Found Pairs: \(self.defaults.integer(forKey: StatisticsKey.pairs.rawValue)) \n Total Flips: \(self.defaults.integer(forKey: StatisticsKey.flips.rawValue))"
        }
        
        //update defaults if result is better:
        if gameInterface.pairsCounter > defaults.integer(forKey: StatisticsKey.pairs.rawValue) {
            defaults.set(prop.totalTime, forKey: StatisticsKey.time.rawValue)
            defaults.set(gameInterface.pairsCounter, forKey: StatisticsKey.pairs.rawValue)
            defaults.set(gameInterface.flipsCounter, forKey: StatisticsKey.flips.rawValue)
            print("defaults updated!")
        } else {
            print("defaults are NOT updated!")
        }
        
        print("default time: \(defaults.integer(forKey: StatisticsKey.time.rawValue))")
        print("default pairs: \(defaults.integer(forKey: StatisticsKey.pairs.rawValue))")
        print("default flips: \(defaults.integer(forKey: StatisticsKey.flips.rawValue))")
        
        //restart and menu button animations:
        UIView.transition(with: self.gameInterface.backToMenuButton, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: self.gameInterface.restartButton, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
        
        //cards animations:
        for card in Properties.cardButtons {
            card.pulsateRemove()
            
            UIButton.animate(withDuration: 1, animations: {
                card.alpha = 0.4
                card.isHidden = false
                card.isEnabled = false
            })
        }
    }
    
    //MARK: - restartTapped:
    
    @objc func restartTapped(_ sender: UIButton) {
        sender.bounce(sender)
        
        //reset timer:
        prop.timer.invalidate()
        
        //animation:
        gameInterface.restartButton.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        Properties.activatedCards.removeAll()
        Properties.activatedButtons.removeAll()
        
        //setup time:
        self.gameInterface.timeCounter = self.prop.standardTimeCounter
        //total time for statistics:
        self.prop.totalTime = self.gameInterface.timeCounter
        print("total time: \(self.prop.totalTime)")
        
        loadLevel()
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.gameInterface.gameOverLabel.alpha = 0
            self.gameInterface.statisticsView.alpha = 0
            self.gameInterface.backToMenuButton.alpha = 0
            self.gameInterface.restartButton.alpha = 0
            self.gameInterface.flipsCounter = 0
            self.gameInterface.pairsCounter = 0
            
            //reset cards:
            for card in Properties.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    let backgroundImage = UIImage(named: ImageKey.backImage.rawValue)
                    card.setBackgroundImage(backgroundImage, for: .normal)
                    card.alpha = 1
                    card.isEnabled = true
                })
            }
        }
    }
    
    //MARK: - muteButtonTapped:
    
    @objc func muteButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //set UserDefaults:
        var muted = defaults.bool(forKey: AudioKey.isMuted.rawValue)
        
        //set to have an access in viewDidLoad() to control volume level
        prop.mutedGeneral = muted
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        if muted {
            //set UserDefaults:
            defaults.setColor(color: UIColor.systemPink, forKey: ColorKey.myColor.rawValue)
            defaults.set(false, forKey: AudioKey.isMuted.rawValue)
            defaults.set(0.1, forKey: AudioKey.volumeLevel.rawValue)
            
            //get UserDefaults:
            muted = defaults.bool(forKey: AudioKey.isMuted.rawValue)
            sender.backgroundColor = defaults.colorForKey(key: ColorKey.myColor.rawValue)
            audioFX.backgroundMusic?.volume = defaults.float(forKey: AudioKey.volumeLevel.rawValue)
        } else {
            //set UserDefaults:
            defaults.setColor(color: UIColor.gray, forKey: ColorKey.myColor.rawValue)
            defaults.set(true, forKey: AudioKey.isMuted.rawValue)
            defaults.set(0, forKey: AudioKey.volumeLevel.rawValue)
            
            //get UserDefaults:
            muted = defaults.bool(forKey: AudioKey.isMuted.rawValue)
            sender.backgroundColor = defaults.colorForKey(key: ColorKey.myColor.rawValue)
            audioFX.backgroundMusic?.volume = defaults.float(forKey: AudioKey.volumeLevel.rawValue)
        }
    }
    
    //MARK: - menuButtonTapped:
    
    @objc func menuButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            //reset timer:
            if self.prop.timer != nil {
                self.prop.timer.invalidate()
                print("timer invalidated!")
            }
            
            //remove old subview:
            self.gameInterface.buttonsView.subviews.forEach { $0.removeFromSuperview() }
            
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    //MARK: - cardTapped:
    
    @objc func cardTapped(_ sender: UIButton) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.flip1.rawValue, type: AudioTypeKey.wav.rawValue)
        
        //flip card:
        if !Properties.activatedButtons.contains(sender) {
            guard let imageName = sender.titleLabel?.text else { return }
            let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
            sender.setBackgroundImage(image, for: .normal)
            
            //pulse animation:
            sender.pulsate()
            
            //flip animation:
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
            Properties.activatedCards.append(imageName)
            Properties.activatedButtons.append(sender)
            
            //setup Timer:
            if gameInterface.flipsCounter < 1 {
                setupTimer()
            }
            
            prop.cardCounter += 1    //0 - 2
            gameInterface.flipsCounter += 1
            
        } else {
            
            //MARK: - Flip Back
            
            //flip back:
            let backgroundImage = UIImage(named: ImageKey.backImage.rawValue)
            sender.setBackgroundImage(backgroundImage, for: .normal)
            
            //flip back animation:
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            //audioFX
            try? audioFX.playFX(file: AudioFileKey.flip2.rawValue, type: AudioTypeKey.wav.rawValue)
            
            //kill pulse animation:
            DispatchQueue.main.asyncAfter(deadline: .now() + prop.flipAnimationTime) {
                sender.pulsateRemove()
            }
            
            //reset cards:
            Properties.activatedButtons.removeLast()
            Properties.activatedCards.removeLast()
            
            //reset counter:
            prop.cardCounter = 0
            
        }
        print(Properties.activatedCards)
        
        //auto-disable cards after 2 clicked:
        if prop.cardCounter == 2 {
            
            //SYNC UserInteractionEnabled with Kill animation:
            for card in Properties.cardButtons {
                card.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + prop.syncDisableAnimation) {
                    card.isUserInteractionEnabled = true
                }
            }
            
            //MARK: - Match:
            
            //check for duplicates (to avoid self-match with 1 item in array):
            if Properties.activatedCards.last == Properties.activatedCards.first && Properties.activatedCards.count > 1 {
                //match cards!
                print("BINGO")
//                addCoin()         //FOR TESTING
                
                //remove from prop.pairList: (to sort pairs for next level)
                gameInterface.pairsCounter += 1
                if let cardName = sender.titleLabel?.text {
                    print("\(cardName) removed from list")
                    Properties.pairList.removeAll { $0 == cardName }
                    print(Properties.pairList)
                    print(Properties.pairList.count)
                }
                
                //add Coin each 10 pairs:
                if gameInterface.pairsCounter.isMultiple(of: 10) {
                    print("+ COIN!")
                    addCoin()
                }
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    //audioFX2:
                    try? self.audioFX.playGameStateFX(file: AudioFileKey.matchIgnite.rawValue, type: AudioTypeKey.wav.rawValue)
                    
                    //haptics:
                    HapticsManager.shared.vibrate(for: .success)
                    
                    //animation:
                    UIView.transition(with: Properties.activatedButtons.last!, duration: 0.7, options: .transitionCurlUp, animations: {
                        Properties.activatedButtons.last?.alpha = 0.3
                        Properties.activatedButtons.last?.isEnabled = false
                        Properties.activatedButtons.last?.pulsateRemove()
                    })
                    
                    UIView.transition(with: Properties.activatedButtons.first!, duration: 0.7, options: .transitionCurlUp, animations: {
                        Properties.activatedButtons.first?.alpha = 0.3
                        Properties.activatedButtons.first?.isEnabled = false
                        Properties.activatedButtons.first?.pulsateRemove()
                    })
                    
                    //reset cards:
                    Properties.activatedCards.removeAll()
                    Properties.activatedButtons.removeAll()
                    
                    //reset counter:
                    self.prop.cardCounter = 0
                }
                
                //MARK: - Not Match:
                
            } else {
                //not match:
                print("NOT MATCH")
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + prop.timeToShowBothCards) {
                    //audioFX:
                    try? self.audioFX.playFX(file: AudioFileKey.flip2.rawValue, type: AudioTypeKey.wav.rawValue)
                    
                    //haptics:
                    HapticsManager.shared.vibrate(for: .error)
                    
                    //animations:
                    UIView.transition(with: Properties.activatedButtons.last!, duration: self.prop.flipBackAnimationTime, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                    UIView.transition(with: Properties.activatedButtons.first!, duration: self.prop.flipBackAnimationTime, options: .transitionFlipFromBottom, animations: nil, completion: nil)
                    
                    //show card cover:
                    let backgroundImage = UIImage(named: ImageKey.backImage.rawValue)
                    Properties.activatedButtons.last!.setBackgroundImage(backgroundImage, for: .normal)
                    Properties.activatedButtons.first!.setBackgroundImage(backgroundImage, for: .normal)
                }
                
                //kill pulsate animation:
                DispatchQueue.main.asyncAfter(deadline: .now() + prop.syncDisableAnimation) {
                    //SYNC with kill animation!!!
                    Properties.activatedButtons.last?.pulsateRemove()
                    Properties.activatedButtons.first?.pulsateRemove()
                    
                    //reset cards:
                    Properties.activatedCards.removeAll()
                    Properties.activatedButtons.removeAll()
                    
                    //reset counter:
                    self.prop.cardCounter = 0
                }
            }
        }
        
        if Properties.pairList.isEmpty {
            print("PAIR LIST IS EMPTY")
            nextLevel()
        }
    }
    
    //MARK: - Settings Button Tapped:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        sender.bounce(sender)
        
        //UI Hide/Enable
        if gameInterface.settingsView.alpha == 0 {
            gameInterface.settingsView.alpha = 1
            gameInterface.buttonsView.alpha = 0.3
            DispatchQueue.main.async {
                self.gameInterface.buttonsView.isUserInteractionEnabled = false
            }
        } else {
            gameInterface.settingsView.alpha = 0
            gameInterface.buttonsView.alpha = 1
            DispatchQueue.main.async {
                self.gameInterface.buttonsView.isUserInteractionEnabled = true
            }
        }
        
        //Pause & Resume Timer:
        //Check if timer is nil:
        if prop.timer != nil {
            print("timer is NOT nil")
            if prop.isPaused {
                setupTimer()
                prop.isPaused = false
            } else {
                prop.timer.invalidate()
                prop.isPaused = true
            }
        } else {
            print("timer is NIL")
        }
    }
    
    //MARK: - Setup Timer:
    
    @objc func setupTimer() {
        //set up Timer:
        prop.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.gameInterface.timeCounter > 0 {
                self.gameInterface.timeCounter -= 1
            } else {
                //GAME OVER:
                self.prop.timer.invalidate()
                self.gameOver()
            }
        }
    }
    
    //MARK: - Setup Buttons:
    
    fileprivate func setupButtons(rows: Int, columns: Int) {
        let rawWidth = gameInterface.buttonsView.frame.width
        let resultWidth = Int(rawWidth) / columns
        
        let rawHeight = gameInterface.buttonsView.frame.height
        let resultHeight = Int(rawHeight) / rows
        
        for row in 0..<rows {
            for column in 0..<columns {
                let cardButton = UIButton(type: .system)
                let backgroundImage = UIImage(named: ImageKey.backImage.rawValue)
                cardButton.setBackgroundImage(backgroundImage, for: .normal)
                cardButton.setTitleColor(prop.debugFontColor, for: .normal)
                cardButton.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Bold", size: prop.debugFontSize)
                cardButton.layer.borderWidth = 0
                cardButton.layer.cornerRadius = 10
                cardButton.layer.borderColor = UIColor.systemBrown.cgColor
                cardButton.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                cardButton.frame = CGRect(x: column * resultWidth, y: row * resultHeight, width: resultWidth, height: resultHeight)
                //shadows {
                cardButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor
                cardButton.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
                cardButton.titleLabel?.layer.shadowRadius = 2
                cardButton.titleLabel?.layer.shadowOpacity = 2
                cardButton.titleLabel?.layer.shouldRasterize = true
                cardButton.titleLabel?.layer.rasterizationScale = UIScreen.main.scale
                //shadows }
                
                gameInterface.buttonsView.addSubview(cardButton)
                Properties.cardButtons.append(cardButton)
            }
        }
    }
    
    func plusCoinAnimation() {
        
        gameInterface.plusCoinsAnimationsLabel.alpha = 1
        
        let thePath = CGMutablePath()
        let randomNumber = Int.random(in: 1...3)
        
        switch randomNumber {
        case 1:
            thePath.move(to: CGPoint(x: 200, y: 150))
            thePath.addCurve(to: CGPoint(x: 200, y: 100),
                             control1: CGPoint(x: 0, y: 0),
                             control2: CGPoint(x:200, y: 0))
        case 2:
            thePath.move(to: CGPoint(x: 60, y: 200))
            thePath.addCurve(to: CGPoint(x: 100, y: 100),
                             control1: CGPoint(x: 100, y: 20),
                             control2: CGPoint(x:200, y: 20))
        case 3:
            thePath.move(to: CGPoint(x: 300, y: 100))
            thePath.addCurve(to: CGPoint(x: 300, y: 100),
                             control1: CGPoint(x: 0, y: 25),
                             control2: CGPoint(x: 0, y: 25))
        default:
            break
        }

        let theAnimaton = CAKeyframeAnimation(keyPath: "position")
        theAnimaton.path = thePath
        theAnimaton.duration = 5
        gameInterface.plusCoinsAnimationsLabel.layer.add(theAnimaton, forKey: "position")
        
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 1
        fadeAnim.toValue = 0.0
        fadeAnim.duration = 2.0
        gameInterface.plusCoinsAnimationsLabel.layer.add(fadeAnim, forKey: "fadeAnim")
        gameInterface.plusCoinsAnimationsLabel.layer.opacity = 0.0
    }
    
    //MARK: - Add Coin:
    
    func addCoin() {
        //Animations +1Coin & CoinCounter bounce:
        DispatchQueue.main.async {
            self.plusCoinAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.gameInterface.coinLabel.spring(self.gameInterface.coinLabel)
            self.gameInterface.coins += 1
            self.defaults.set(self.gameInterface.coins, forKey: CoinsKey.coins.rawValue)
        }
    }
}
