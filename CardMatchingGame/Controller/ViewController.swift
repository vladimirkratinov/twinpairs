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
    var prop = Properties()
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = UI.myView
        
        UI.setupSubviews()
        UI.setupConstraints()
        
        //timer to load and get the width & height properties!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.setupButtons(rows: 2, columns: 2)
        }
        
        UI.restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        UI.backToMenuButton.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        UI.menuButton.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        UI.muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        //timer to load and get the width & height properties!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let testWidth = self.UI.buttonsView.frame.width
            print(testWidth)
            
            self.loadLevel()
        }
        
        //debugging Constraints:
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        //audioFX:
        DispatchQueue.main.async {
            try? self.audioFX.playBackgroundMusic(file: "creepy", type: "mp3")
            if self.prop.mutedGeneral {
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
        prop.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.UI.timeCounter > 0 {
                self.UI.timeCounter -= 1
            } else {
                //GAME OVER:
                self.prop.timer.invalidate()
                self.gameOver()
            }
        }
    }
    
    //MARK: - LoadLevel:
    
    func loadLevel() {
        //setup time for timer:
        UI.timeCounter = 60
        
        //reset card counter:
        prop.cardCounter = 0
        
        //sync Kill pulsate animation & isUserInteractionEnabled
        prop.syncDisableAnimation = 1.6
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupTimer()
        }
        
        //if same amount card buttons and cardlist:
        if prop.cardButtons.count == prop.cardList.count {
            
            //create pair list:
            prop.pairList = prop.cardList
            
            //shuffle card list:
            let shuffledList = prop.cardList.shuffled()
            
            for i in 0..<prop.cardButtons.count {
                prop.cardButtons[i].setTitle(shuffledList[i], for: .normal)
                prop.cardButtons[i].setTitleColor(UIColor.white, for: .normal)               //debug title color
                prop.cardButtons[i].titleLabel?.font = UIFont(name: "Helvetica", size: 20)   //debug title size
                prop.cardButtons[i].setImage(nil, for: .normal)                              //debug image
            }
                
            //button names list:
            print("prop.cardButtons Count: \(prop.cardButtons.count)")
            print("prop.cardList Count: \(prop.cardList.count)")
            
        } else {
            //create lower amounts of card list:
            prop.lowerAmmountOfCardsList = prop.cardList
            
            //remove other cards, if less then 20
            let sum = prop.cardList.count - prop.cardButtons.count
            
            //BUG ??? Range requires lowerBound <= upperBound
            for _ in 0..<sum {
                if sum > 0 {
                    prop.lowerAmmountOfCardsList.removeLast()
                } else {
                    break
                }
            }
            print(prop.lowerAmmountOfCardsList)
            
            //create pair list:
            prop.pairList = prop.lowerAmmountOfCardsList
            
            //shuffle card list:
            let shuffledList = prop.lowerAmmountOfCardsList.shuffled()
            
            for i in 0..<prop.cardButtons.count {
                prop.cardButtons[i].setTitle(shuffledList[i], for: .normal)
                prop.cardButtons[i].setTitleColor(UIColor.white, for: .normal)               //debug title color
                prop.cardButtons[i].titleLabel?.font = UIFont(name: "Helvetica", size: 20)   //debug title size
                prop.cardButtons[i].setImage(nil, for: .normal)                              //debug image
            }
            
            //button names list:
            print("prop.cardButtons Count: \(prop.cardButtons.count)")
            print("lowerAmmountOfCardsList Count: \(prop.lowerAmmountOfCardsList.count)")
        }
    }
    
    //MARK: - nextLevel:
    
    func nextLevel() {
        //audioFX:
        try? audioFX.playFX(file: "victory", type: "wav")
        
        //nextLevelLabel animation:
        UIView.animate(withDuration: 0.5, animations:  {
            self.UI.nextLevelLabel.alpha = 1
            self.UI.gameOverLabel.pulsate()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            
        }
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //invalidateTimer:
            self.prop.timer.invalidate()
            
            self.UI.nextLevelLabel.alpha = 0
            
            self.prop.activatedCards.removeAll()
            self.prop.activatedButtons.removeAll()
            self.prop.cardButtons.removeAll()           //!!!!fixed bug - reset cardButtons array!!!!
            
            self.setupButtons(rows: 5, columns: 4)
            self.loadLevel()
            
            
            //reset cards color:
            for card in self.prop.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    card.pulsateRemove()
                    card.alpha = 1
                    card.isEnabled = true
                    card.tintColor = UIColor.systemOrange
                    card.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
//                    card.setImage(UIImage(named: "Spider"), for: .normal)
                    card.setImage(nil, for: .normal)                            //debug image
                })
            }
        }
    }
    
    //MARK: - GameOver:
    
    func gameOver() {
        //reset timer:
        prop.timer.invalidate()
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
        for card in prop.cardButtons {
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
        prop.timer.invalidate()
        
        //animation:
        UI.restartButton.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFXName.tinyButtonPress.rawValue, type: "wav")
        
        prop.activatedCards.removeAll()
        prop.activatedButtons.removeAll()
        
        loadLevel()
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.UI.gameOverLabel.alpha = 0
            self.UI.backToMenuButton.alpha = 0
            self.UI.restartButton.alpha = 0
            self.UI.flipsCounter = 0
            self.UI.pairsCounter = 0
            
            //reset cards color:
            for card in self.prop.cardButtons {
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
        prop.mutedGeneral = muted   //set prop.mutedGeneral - to have an access in viewDidLoad() to control volume level
        
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
        if !prop.activatedButtons.contains(sender) {
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
            
            prop.activatedCards.append(imageName)
            prop.activatedButtons.append(sender)
            
            prop.cardCounter += 1    //0 - 2
            UI.flipsCounter += 1
            
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
            prop.activatedButtons.removeLast()
            prop.activatedCards.removeLast()
            
            //reset counter:
            prop.cardCounter = 0
            
        }
        print(prop.activatedCards)
        
        //auto-disable cards after 2 clicked:
        if prop.cardCounter == 2 {
            
            //SYNC with kill animation!!!
            for card in prop.cardButtons {
                card.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + prop.syncDisableAnimation) {
                    card.isUserInteractionEnabled = true
                }
            }
            
            //check for duplicates (to avoid self-match with 1 item in array):
            if prop.activatedCards.last == prop.activatedCards.first && prop.activatedCards.count > 1 {
                //match cards!
                print("BINGO")
                
                //remove from prop.pairList: (to sort pairs for next level)
                UI.pairsCounter += 1
                if let cardName = sender.titleLabel?.text {
                    print("\(cardName) removed from list")
                    prop.pairList.removeAll { $0 == cardName }
                    print(prop.pairList)
                    print(prop.pairList.count)
                }
                
                //audioFX1:
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    //audioFX2:
                    try? self.audioFX.playFX(file: AudioFXName.matchIgnite.rawValue, type: "wav")
                    //animation:
                    UIView.transition(with: self.prop.activatedButtons.last!, duration: 1, options: .transitionCurlUp, animations: {
                        self.prop.activatedButtons.last?.alpha = 0
                    } ) { finished in
                        self.prop.activatedButtons.last?.isHidden = true
                        self.prop.activatedButtons.last?.alpha = 1
                    }
                    
                    UIView.transition(with: self.prop.activatedButtons.first!, duration: 1, options: .transitionCurlUp, animations: {
                        self.prop.activatedButtons.first?.alpha = 0
                    } ) { finished in
                        self.prop.activatedButtons.first?.isHidden = true
                        self.prop.activatedButtons.first?.alpha = 1
                    }
                    
                    //reset cards:
                    self.prop.activatedCards.removeAll()
                    self.prop.activatedButtons.removeAll()
                    
                    //reset card list:
                    
                    //reset counter:
                    self.prop.cardCounter = 0
                }
            } else {
                //not match:
                print("NOT MATCH")
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //audioFX:
                    try? self.audioFX.playFX(file: AudioFXName.flip2.rawValue, type: "wav")
                    
                    //animations:
                    UIView.transition(with: self.prop.activatedButtons.last!, duration: 0.7, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                    UIView.transition(with: self.prop.activatedButtons.first!, duration: 0.7, options: .transitionFlipFromBottom, animations: nil, completion: nil)
                    
                    //hide images:
                    self.prop.activatedButtons.last!.setImage(UIImage(named: "Spider"), for: .normal)
                    self.prop.activatedButtons.first!.setImage(UIImage(named: "Spider"), for: .normal)
                    
                    //change image color:
                    self.prop.activatedButtons.last!.tintColor = UIColor.orange
                    self.prop.activatedButtons.first!.tintColor = UIColor.orange
                    
                    //reset background color:
                    self.prop.activatedButtons.last!.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    self.prop.activatedButtons.first!.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    
                }
                
                //kill pulsate animation:
                DispatchQueue.main.asyncAfter(deadline: .now() + prop.syncDisableAnimation) {
                    //SYNC with kill animation!!!
                    self.prop.activatedButtons.last?.pulsateRemove()
                    self.prop.activatedButtons.first?.pulsateRemove()
                    
                    //reset cards:
                    self.prop.activatedCards.removeAll()
                    self.prop.activatedButtons.removeAll()
                    
                    //reset counter:
                    self.prop.cardCounter = 0
                }
            }
        }
        
        if prop.pairList.isEmpty {
            print("PAIR LIST IS EMPTY")
            nextLevel()
        }
    }
    
    //MARK: - Setup Buttons:
    
    fileprivate func setupButtons(rows: Int, columns: Int) {
        let rawWidth = UI.buttonsView.frame.width
        let resultWidth = Int(rawWidth) / columns
        
        let rawHeight = UI.buttonsView.frame.height
        let resultHeight = Int(rawHeight) / rows
        
        
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
                cardButton.frame = CGRect(x: column * resultWidth, y: row * resultHeight, width: resultWidth, height: resultHeight)
                
                UI.buttonsView.addSubview(cardButton)
                prop.cardButtons.append(cardButton)
            }
        }
    }
}
