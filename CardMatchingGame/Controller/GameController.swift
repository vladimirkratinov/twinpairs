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
    let menuInterface = MenuInterface()
    var gameLogic = GameLogic()
    var gestureRecognizer: UITapGestureRecognizer?
    
    override func loadView() {
        view = gameInterface.gameView
        
        gameInterface.setupSubviews()
        gameInterface.setupConstraints()
        
        //timer to load and get the width & height properties!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.setupButtons(rows: Properties.rows, columns: Properties.columns)
        }
//        gameInterface.restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        gameInterface.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
        gameInterface.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        gameInterface.quitButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        gameInterface.muteMusicButton.addTarget(self, action: #selector(muteMusicTapped), for: .touchUpInside)
        gameInterface.muteSoundButton.addTarget(self, action: #selector(muteSoundTapped), for: .touchUpInside)
        gameInterface.muteVibrationButton.addTarget(self, action: #selector(muteVibrationTapped), for: .touchUpInside)
//        gameInterface.backgroundButton.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Changing background color:
//        SettingController.changingBackgroundGradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
        
        //Tap Gesture Settings:
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeView),
                                               name: NSNotification.Name("CloseView"),
                                               object: nil)
        //gesture Recognizer:
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView))
        view.addGestureRecognizer(gesture)
        self.gestureRecognizer = gesture
        
        //timer to load and get the width & height properties! (cheating)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let widthButtonsView = self.gameInterface.buttonsView.frame.width
            print("ButtonsView width: \(widthButtonsView)")
            //setup time:
            self.gameInterface.timeCounter = Properties.standardTimeCounter
            //total time for statistics:
            self.prop.totalTime = self.gameInterface.timeCounter
            print("total time: \(self.prop.totalTime)")
            
            self.loadLevel()
        }

        print("selectedCardList: \(Properties.selectedCardList)")
        print("selectedCardSet: \(Properties.selectedCollection)")
        
        //debugging Constraints error message:
//        UserDefaults.standard.set(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //disable gestures:
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //update Coins label:
        gameInterface.coins = Properties.coins

        //ViewAnimator:
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 200)
        gameInterface.buttonsView.animate(animations: [fromAnimation], duration: 0.5)
        
        //updateSettingsUIButtonsColor:
        updateSettingsUIButtonsColor()
    }
    
    //MARK: - LoadLevel:
    
    func loadLevel() {
        //reset card counter:
        prop.cardCounter = 0
        
        if Properties.gameIsOver {
            gameOver()              //test Game Over
        }
        
        //SETUP SELECTED CARDS:
        gameLogic.setupSelectedSet(prefix: Properties.selectedCardListNumber)

    }

    //MARK: - nextLevel:
    
    func nextLevel() {
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.victory.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //randomizer nextLevelLabel.text:
        let randomCongratulation = Int.random(in: 1...5)
        
        switch randomCongratulation {
        case 1: gameInterface.nextLevelLabel.text = "Super!"
        case 2: gameInterface.nextLevelLabel.text = "Great!"
        case 3: gameInterface.nextLevelLabel.text = "Amazing!"
        case 4: gameInterface.nextLevelLabel.text = "Well Done!"
        case 5: gameInterface.nextLevelLabel.text = "Good Job!"
        default:
            gameInterface.nextLevelLabel.text = "Bang!"
        }
        
        //nextLevelLabel animation:
        UIView.animate(withDuration: 0.5, animations:  {
            self.gameInterface.nextLevelLabel.alpha = 1
            self.gameInterface.gameOverLabel.pulsate()
        })
        
        UIView.animate(withDuration: 2, animations: {
//            self.gameInterface.buttonsView.alpha = 0
            self.gameInterface.nextLevelLabel.alpha = 0
        })
                
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //remove old subview:
            
            self.gameInterface.buttonsView.subviews.forEach { $0.removeFromSuperview() }

            //RESET CARDS:
            self.resetCards()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 0.6, animations: {
                    self.gameInterface.buttonsView.alpha = 1
                    self.setupButtons(rows: Properties.rows, columns: Properties.columns)
                })
                self.loadLevel()
            }

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
        if prop.timer != nil {
            prop.timer.invalidate()
        }
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.gameOver.rawValue, isMuted: Properties.soundMutedSwitcher)
        //labels animations:
        UIView.animate(withDuration: 0.5, animations:  {
            self.gameInterface.gameOverLabel.alpha = 1
            self.gameInterface.gameOverView.alpha = 1
            self.gameInterface.menuButton.alpha = 1
            self.gameInterface.restartButton.alpha = 1
            self.gameInterface.gameOverLabel.pulsate()
//            self.gameInterface.restartButton.pulsate()
        })
        
        //update statistics UI:
        DispatchQueue.main.async {
            self.gameInterface.yourResultLabel.text = "your result"
            
            self.gameInterface.bestResultLabel.text = "best result"
        }
        
        //update Properties.defaults if result is better:
        if gameInterface.pairsCounter > Properties.defaults.integer(forKey: StatisticsKey.pairs.rawValue) {
            Properties.defaults.set(prop.totalTime, forKey: StatisticsKey.time.rawValue)
            Properties.defaults.set(gameInterface.pairsCounter, forKey: StatisticsKey.pairs.rawValue)
            Properties.defaults.set(gameInterface.flipsCounter, forKey: StatisticsKey.flips.rawValue)
            print("Properties.defaults updated!")
        } else {
            print("Properties.defaults are NOT updated!")
        }
        
        print("default time: \(Properties.defaults.integer(forKey: StatisticsKey.time.rawValue))")
        print("default pairs: \(Properties.defaults.integer(forKey: StatisticsKey.pairs.rawValue))")
        print("default flips: \(Properties.defaults.integer(forKey: StatisticsKey.flips.rawValue))")
        
        //restart and menu button animations:
        UIView.transition(with: self.gameInterface.menuButton, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
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
    
    //MARK: - MenuButtonTapped:
    
    @objc func menuButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.resetCards()
            //reset timer:
            if self.prop.timer != nil {
                self.prop.timer.invalidate()
                print("timer invalidated!")
            }
            //remove old subview:
            self.gameInterface.buttonsView.subviews.forEach { $0.removeFromSuperview() }
            
            let transition = CATransition()
            transition.duration = 0.2
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - cardTapped:
    
    @objc func cardTapped(_ sender: UIButton) {
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.flip1.rawValue, type: AudioTypeKey.wav.rawValue)
        
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
            let backgroundImage = UIImage(named: FigmaKey.cardCover2.rawValue)
            sender.setBackgroundImage(backgroundImage, for: .normal)
            
            //flip back animation:
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            //audioFX
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
//            try? audioFX.playFX(file: AudioFileKey.flip2.rawValue, type: AudioTypeKey.wav.rawValue)
            
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
                addCoin()         //FOR TESTING!
                
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
                    self.audioFX.playAnotherSoundFX(name: AudioFileKey.matchIgnite.rawValue, isMuted: Properties.soundMutedSwitcher)
//                    try? self.audioFX.playGameStateFX(file: AudioFileKey.matchIgnite.rawValue, type: AudioTypeKey.wav.rawValue)
                    
                    //haptics:
                    if Properties.vibrationMutedSwitcher {
                        HapticsManager.shared.vibrate(for: .success)
                    }

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
                    self.audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
//                    try? self.audioFX.playFX(file: AudioFileKey.flip2.rawValue, type: AudioTypeKey.wav.rawValue)
                    
                    //haptics:
                    if Properties.vibrationMutedSwitcher {
                        HapticsManager.shared.vibrate(for: .error)
                    }
                    
                    
                    //animations:
                    UIView.transition(with: Properties.activatedButtons.last!, duration: self.prop.flipBackAnimationTime, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                    UIView.transition(with: Properties.activatedButtons.first!, duration: self.prop.flipBackAnimationTime, options: .transitionFlipFromBottom, animations: nil, completion: nil)
                    
                    //show card cover:
                    let backgroundImage = UIImage(named: FigmaKey.cardCover2.rawValue)
                                        
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
    
    //MARK: - Settings Buttons:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        //UI Hide/Enable
        if gameInterface.settingsView.isHidden {
            gameInterface.settingsView.isHidden = false
            gameInterface.buttonsView.alpha = 0.3
            gameInterface.buttonsView.isUserInteractionEnabled = false
        } else if !gameInterface.settingsView.isHidden {
            gameInterface.settingsView.isHidden = true
            gameInterface.buttonsView.alpha = 1
            gameInterface.buttonsView.isUserInteractionEnabled = true
        }

        print("settings Button is Hidden: \(gameInterface.settingsView.isHidden)")
        
        //Pause & Resume Timer:
        //Check if timer is nil:
        if prop.timer != nil {
            print("Settings: timer is NOT NIL")
            if prop.isPaused {
                setupTimer()
                prop.isPaused = false
            } else {
                prop.timer.invalidate()
                prop.isPaused = true
            }
        } else {
            print("Settings: timer is NIL")
        }
    }
    
    @objc func muteMusicTapped(_ sender: UIButton) {
        SettingController.muteMusicTapped(sender: sender)
    }
    
    @objc func muteSoundTapped(_ sender: UIButton) {
        SettingController.muteSoundTapped(sender: sender)
    }
    
    @objc func muteVibrationTapped(_ sender: UIButton) {
        SettingController.muteVibrationTapped(sender: sender)
    }
    
    @objc func backgroundButtonTapped(_ sender: UIButton) {
        SettingController.backgroundButtonTapped(sender: sender)
    }
    
    //MARK: - Dismiss Settings Veiw:
    
    //We need to have tapped outside of view 2
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let location = tapGestureRecognizer.location(in: gameInterface.settingsView)
        guard gameInterface.settingsView.isHidden == false,
              !gameInterface.settingsView.bounds.contains(location) else { return }
        gameInterface.settingsView.isHidden = true
        gameInterface.buttonsView.alpha = 1
        gameInterface.buttonsView.isUserInteractionEnabled = true
        
        //Check if timer is nil:
        if prop.timer != nil {
            print("Settings: timer is NOT NIL")
            if prop.isPaused {
                setupTimer()
                prop.isPaused = false
            } else {
                prop.timer.invalidate()
                prop.isPaused = true
            }
        } else {
            print("Settings: timer is NIL")
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
                let backgroundImage = UIImage(named: FigmaKey.cardCover2.rawValue)
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
    
    //MARK: - CoinAnimation:
    
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

            Properties.coins += 2
            self.gameInterface.coins += 2
//            self.menuInterface.coins += 2

            Properties.defaults.set(Properties.coins, forKey: CoinsKey.coins.rawValue)
        }
        
        print("properties.coins = \(Properties.coins)")
        print("menuInterface.coins = \(menuInterface.coins)")
        print("gameInterface.coins = \(gameInterface.coins)")
    }
    
    //MARK: - ResetCards:
    
    func resetCards() {
        Properties.activatedCards.removeAll()
        Properties.activatedButtons.removeAll()
        Properties.cardButtons.removeAll()
        Properties.pairList.removeAll()
    }
    
    //MARK: - updateSettingsUIButtonsColor:
    
    func updateSettingsUIButtonsColor() {
        DispatchQueue.main.async {
            let muteMusicColor =        Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            let muteSoundColor =        Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            let muteVibrationColor =    Properties.defaults.colorForKey(key: ColorKey.vibrationButton.rawValue)
            
            //Menu UI:
            self.menuInterface.muteMusicButton.backgroundColor =        muteMusicColor ?? UIColor.systemPink
            self.menuInterface.muteSoundButton.backgroundColor =        muteSoundColor ?? UIColor.systemPink
            self.menuInterface.muteVibrationButton.backgroundColor =    muteVibrationColor ?? UIColor.systemPink
            
            //Game UI:
            self.gameInterface.muteMusicButton.backgroundColor =        muteMusicColor ?? UIColor.systemPink
            self.gameInterface.muteSoundButton.backgroundColor =        muteSoundColor ?? UIColor.systemPink
            self.gameInterface.muteVibrationButton.backgroundColor =    muteVibrationColor ?? UIColor.systemPink
        }
    }
}
