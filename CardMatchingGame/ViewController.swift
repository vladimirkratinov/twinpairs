//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioFX = AudioFX()
    let UI = UserInterface()
    let prop = Properties()
    let defaults = UserDefaults.standard
    
    var cardButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var activatedCards = [String]()
    
    var pairList = [String]()
    
    var mutedGeneral = Bool()
    
    var pairsCounter: Int = 0 {
        didSet {
            UI.pairsLabel.text = "Pairs: \(pairsCounter)"
        }
    }
    var timeCounter: Int = 0 {
        didSet {
            UI.timeLabel.text = "Time: \(timeCounter)"
        }
    }
    var flipsCounter: Int = 0 {
        didSet {
            UI.flipsLabel.text = "Flips: \(flipsCounter)"
        }
    }

    var syncDisableAnimation = 0.0
    var cardCounter = 0
    
    var timer: Timer!
    
    override func loadView() {
        view = UI.myView
        
        UI.setupSubviews()
        UI.setupConstraints()
        setupButtons(rows: 5, columns: 4, width: 97, height: 140)
        
        UI.restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        UI.backToMenuButton.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        UI.menuButton.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        UI.muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        loadLevel()
        
        //debugging Constraints:
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        //audioFX:
        DispatchQueue.main.async {
            try? self.audioFX.playBackgroundMusic(file: "creepy", type: "mp3")
            if self.mutedGeneral {
                self.audioFX.backgroundMusic?.volume = self.defaults.float(forKey: "volumeLevel")
            } else {
                self.audioFX.backgroundMusic?.volume = self.defaults.float(forKey: "volumeLevel")
            }
        }
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
        UI.setGradientBackground()
    }
    
    func setupTimer() {
        //set up Timer:
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeCounter > 0 {
                self.timeCounter -= 1
            } else {
                //GAME OVER:
                timer.invalidate()
                self.gameOver()
            }
        }
    }
    
    //MARK: - LoadLevel:
    
    func loadLevel() {
        //setup time for timer:
        timeCounter = 60
        
        //reset card counter:
        cardCounter = 0
        
        //sync Kill pulsate animation & isUserInteractionEnabled
        syncDisableAnimation = 1.6
        
        //create pair list:
        pairList = cardList
        
        //shuffle card list:
        let shuffledList = cardList.shuffled()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupTimer()
        }
        //button names list:
        print("cardButtons Count: \(cardButtons.count)")
        print("cardList Count: \(cardList.count)")
        
        if cardButtons.count == cardList.count {
            for i in 0..<cardButtons.count {
                cardButtons[i].setTitle(shuffledList[i], for: .normal)
                cardButtons[i].setTitleColor(UIColor.white, for: .normal)               //debug title color
                cardButtons[i].titleLabel?.font = UIFont(name: "Helvetica", size: 20)   //debug title size
                cardButtons[i].setImage(nil, for: .normal)                              //debug image
            }
//            print("cardButtons.count = cardList.count")
        }
    }
    
    //MARK: - nextLevel:
    
    func nextLevel() {
        //audioFX:
        try? audioFX.playFX(file: "victory", type: "wav")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //            self.updateUI()
        }
        
        //nextLevelLabel animation:
        UIView.animate(withDuration: 0.5, animations:  {
            self.UI.nextLevelLabel.alpha = 1
            self.UI.gameOverLabel.pulsate()
        })
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //invalidateTimer:
            self.timer.invalidate()
            
            self.UI.nextLevelLabel.alpha = 0
            
            self.activatedCards.removeAll()
            self.activatedButtons.removeAll()
            
            self.loadLevel()
            
            //reset cards color:
            for card in self.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    card.pulsateRemove()
                    card.alpha = 1
                    card.isEnabled = true
                    card.tintColor = UIColor.systemOrange
                    card.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    card.setImage(UIImage(named: "Spider"), for: .normal)
                })
            }
        }
    }
    
    //MARK: - GameOver:
    
    func gameOver() {
        //reset timer:
        timer.invalidate()
        //audioFX:
        try? audioFX.playFX(file: "gameOver", type: "wav")
        //labels animations:
        UIView.animate(withDuration: 0.5, animations:  {
            self.UI.gameOverLabel.alpha = 1
            self.UI.backToMenuButton.alpha = 1
            self.UI.restartButton.alpha = 1
            self.UI.gameOverLabel.pulsate()
            self.UI.restartButton.pulsate()
        })
        
        //restart and menu button animations:
        UIView.transition(with: self.UI.backToMenuButton, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
        UIView.transition(with: self.UI.restartButton, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
        
        //cards animations:
        for card in cardButtons {
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
        timer.invalidate()
        
        //animation:
        UI.restartButton.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFXName.tinyButtonPress.rawValue, type: "wav")
        
        activatedCards.removeAll()
        activatedButtons.removeAll()
        
        loadLevel()
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.UI.gameOverLabel.alpha = 0
            self.UI.backToMenuButton.alpha = 0
            self.UI.restartButton.alpha = 0
            self.flipsCounter = 0
            self.pairsCounter = 0
            
            //reset cards color:
            for card in self.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    card.alpha = 1
                    card.isEnabled = true
                    card.tintColor = UIColor.darkGray
                    card.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    card.setImage(UIImage(named: "Spider"), for: .normal)
                })
            }
        }
    }
    
    //MARK: - muteButtonTapped:
    
    @objc func muteButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        //set UserDefaults:
        var muted = defaults.bool(forKey: "isMuted")
        mutedGeneral = muted   //set mutedGeneral - to have an access in viewDidLoad() to control volume level
        
        //audioFX:
        try? audioFX.playFX(file: AudioFXName.tinyButtonPress.rawValue, type: "wav")
        
        if muted {
            //set UserDefaults:
            defaults.setColor(color: UIColor.systemPink, forKey: "myColor")
            defaults.set(false, forKey: "isMuted")
            defaults.set(0.1, forKey: "volumeLevel")
            
            //get UserDefaults:
            muted = defaults.bool(forKey: "isMuted")
            sender.backgroundColor = defaults.colorForKey(key: "myColor")
            audioFX.backgroundMusic?.volume = defaults.float(forKey: "volumeLevel")
        } else {
            //set UserDefaults:
            defaults.setColor(color: UIColor.gray, forKey: "myColor")
            defaults.set(true, forKey: "isMuted")
            defaults.set(0, forKey: "volumeLevel")
            
            //get UserDefaults:
            muted = defaults.bool(forKey: "isMuted")
            sender.backgroundColor = defaults.colorForKey(key: "myColor")
            audioFX.backgroundMusic?.volume = defaults.float(forKey: "volumeLevel")
        }
    }
    
    //MARK: - backToMenuButtonTapped:
    
    @objc func backToMenuButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFXName.tinyButtonPress.rawValue, type: "wav")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    //MARK: - cardTapped:
    
    @objc func cardTapped(_ sender: UIButton) {
        //audioFX:
        try? audioFX.playFX(file: AudioFXName.flip1.rawValue, type: "wav")
        
        //flip card:
        if !activatedButtons.contains(sender) {
            guard let imageName = sender.titleLabel?.text else { return }
            
            let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            sender.tintColor = UIColor.black
            sender.setImage(image, for: .normal)
            sender.setTitle(nil, for: .normal)
            sender.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(0.3)
            
            //pulse animation:
            sender.pulsate()
            
            //flip animation:
            UIView.transition(with: sender, duration: 0.8, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
            activatedCards.append(imageName)
            activatedButtons.append(sender)
            
            cardCounter += 1    //0 - 2
            flipsCounter += 1
            
        } else {
            //flip back:
            sender.tintColor = UIColor.orange
            sender.setImage(UIImage(named: "Spider"), for: .normal)
            sender.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
            //flip back animation:
            UIView.transition(with: sender, duration: 0.8, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            //audioFX
            try? audioFX.playFX(file: AudioFXName.flip2.rawValue, type: "wav")
            
            //kill pulse animation:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                sender.pulsateRemove()
            }
            
            //reset cards:
            activatedButtons.removeLast()
            activatedCards.removeLast()
            
            //reset counter:
            cardCounter = 0
            
        }
        print(activatedCards)
        
        //auto-disable cards after 2 clicked:
        if cardCounter == 2 {
            
            //SYNC with kill animation!!!
            for card in cardButtons {
                card.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + syncDisableAnimation) {
                    card.isUserInteractionEnabled = true
                }
            }
            
            //check for duplicates (to avoid self-match with 1 item in array):
            if activatedCards.last == activatedCards.first && activatedCards.count > 1 {
                //match cards!
                print("BINGO")
                
                //remove from pairList: (to sort pairs for next level)
                pairsCounter += 1
                if let cardName = sender.titleLabel?.text {
                    print("\(cardName) removed from list")
                    pairList.removeAll { $0 == cardName }
                    print(pairList)
                    print(pairList.count)
                }
                
                //audioFX1:
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    //audioFX2:
                    try? self.audioFX.playFX(file: AudioFXName.matchIgnite.rawValue, type: "wav")
                    //animation:
                    UIView.transition(with: self.activatedButtons.last!, duration: 1, options: .transitionCurlUp, animations: {
                        self.activatedButtons.last?.alpha = 0
                    } ) { finished in
                        self.activatedButtons.last?.isHidden = true
                        self.activatedButtons.last?.alpha = 1
                    }
                    
                    UIView.transition(with: self.activatedButtons.first!, duration: 1, options: .transitionCurlUp, animations: {
                        self.activatedButtons.first?.alpha = 0
                    } ) { finished in
                        self.activatedButtons.first?.isHidden = true
                        self.activatedButtons.first?.alpha = 1
                    }
                    
                    //reset cards:
                    self.activatedCards.removeAll()
                    self.activatedButtons.removeAll()
                    
                    //reset card list:
                    
                    //reset counter:
                    self.cardCounter = 0
                }
            } else {
                //not match:
                print("NOT MATCH")
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //audioFX:
                    try? self.audioFX.playFX(file: AudioFXName.flip2.rawValue, type: "wav")
                    
                    //animations:
                    UIView.transition(with: self.activatedButtons.last!, duration: 0.7, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                    UIView.transition(with: self.activatedButtons.first!, duration: 0.7, options: .transitionFlipFromBottom, animations: nil, completion: nil)
                    
                    //hide images:
                    self.activatedButtons.last!.setImage(UIImage(named: "Spider"), for: .normal)
                    self.activatedButtons.first!.setImage(UIImage(named: "Spider"), for: .normal)
                    
                    //change image color:
                    self.activatedButtons.last!.tintColor = UIColor.orange
                    self.activatedButtons.first!.tintColor = UIColor.orange
                    
                    //reset background color:
                    self.activatedButtons.last!.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    self.activatedButtons.first!.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    
                }
                
                //kill pulsate animation:
                DispatchQueue.main.asyncAfter(deadline: .now() + syncDisableAnimation) {
                    //SYNC with kill animation!!!
                    self.activatedButtons.last?.pulsateRemove()
                    self.activatedButtons.first?.pulsateRemove()
                    
                    //reset cards:
                    self.activatedCards.removeAll()
                    self.activatedButtons.removeAll()
                    
                    //reset counter:
                    self.cardCounter = 0
                }
            }
        }
        
        if pairList.isEmpty {
            print("PAIR LIST IS EMPTY")
            nextLevel()
        }
    }
    
    //MARK: - Setup Buttons:
    
    fileprivate func setupButtons(rows: Int, columns: Int, width: Int, height: Int) {
        for row in 0..<rows {
            for column in 0..<columns {
                let cardButton = UIButton(type: .system)
                cardButton.layer.borderWidth = 3
                cardButton.layer.cornerRadius = 10
                cardButton.layer.borderColor = UIColor.systemBrown.cgColor
                cardButton.tintColor = UIColor.darkGray
                cardButton.setImage(UIImage(named: "Spider"), for: .normal)
                cardButton.imageView?.contentMode = .scaleAspectFit
                cardButton.imageView?.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9)       //scale Size
                cardButton.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!)
                cardButton.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                cardButton.frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                
                UI.buttonsView.addSubview(cardButton)
                cardButtons.append(cardButton)
            }
        }
    }
}
