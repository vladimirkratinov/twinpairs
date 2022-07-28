//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/26.
//

import UIKit

class ViewController: UIViewController {
    
    var cardButton: UIButton!
    var restartButton: UIButton!
    var backToMenuButton: UIButton!
    var buttonsView: UIView!
    
    var widthCounter = Int()         //130
    var heightCounter = Int()        //180
    var rowCounter = Int()
    var columnCounter = Int()
    
    var cardButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var activatedCards = [String]()
//    var cardList = ["Bat", "Bat",
//                    "Bones", "Bones",
//                    "Cauldron", "Cauldron",
//        ]
    
    var cardList = ["Bat", "Bat",
                    "Bones", "Bones",
                    "Cauldron", "Cauldron",
                    "Skull", "Skull",
                    "Ghost",  "Ghost",
                    "Pumpkin", "Pumpkin",
                    "Eye", "Eye",
                    "Dracula", "Dracula",
                    "Spider", "Spider",
                    "Cobweb", "Cobweb"
        ]
    
    var pairList = [String]()
    
    var timeLabel: UILabel!
    var flipsLabel: UILabel!
    var gameOverLabel: UILabel!
    var nextLevelLabel: UILabel!
    var pairsLabel: UILabel!
    
    var pairsCounter: Int = 0 {
        didSet {
            pairsLabel.text = "Pairs: \(pairsCounter)"
        }
    }
    
    var timeCounter: Int = 0 {
        didSet {
            timeLabel.text = "Time: \(timeCounter)"
        }
    }
    var flipsCounter: Int = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flipsCounter)"
        }
    }
    
    var syncDisableAnimation: Double = 0
    var cardCounter = 0
    
    var timer: Timer!
    var isGameOver = false
    
    override func loadView() {
        view = UIView()
//        view.backgroundColor = UIColor.white
        self.view = view
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .left
        timeLabel.text = "Time: \(timeCounter)"
        timeLabel.font = UIFont(name: "Baskerville-SemiBold", size: 25)
        view.addSubview(timeLabel)
        
        flipsLabel = UILabel()
        flipsLabel.translatesAutoresizingMaskIntoConstraints = false
        flipsLabel.textAlignment = .right
        flipsLabel.text = "Flips: 0"
        flipsLabel.font = UIFont(name: "Baskerville-SemiBold", size: 25)
        view.addSubview(flipsLabel)
        
        pairsLabel = UILabel()
        pairsLabel.translatesAutoresizingMaskIntoConstraints = false
        pairsLabel.textAlignment = .right
        pairsLabel.text = "Pairs: "
        pairsLabel.font = UIFont(name: "Baskerville-SemiBold", size: 25)
        view.addSubview(pairsLabel)
        
        gameOverLabel = UILabel()
        gameOverLabel.alpha = 0
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "GAME OVER!"
        gameOverLabel.font = UIFont(name: "Baskerville-SemiBold", size: 55)
        gameOverLabel.textColor = UIColor.yellow
        //shadows {
        gameOverLabel.layer.shadowColor = UIColor.black.cgColor
        gameOverLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        gameOverLabel.layer.shadowRadius = 1
        gameOverLabel.layer.shadowOpacity = 1.0
        gameOverLabel.layer.shouldRasterize = true
        gameOverLabel.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        view.addSubview(gameOverLabel)
        
        nextLevelLabel = UILabel()
        nextLevelLabel.alpha = 0
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        nextLevelLabel.textAlignment = .center
        nextLevelLabel.text = "NEXT LEVEL!"
        nextLevelLabel.font = UIFont(name: "Baskerville-SemiBold", size: 45)
        nextLevelLabel.textColor = UIColor.green
        //shadows {
        nextLevelLabel.layer.shadowColor = UIColor.black.cgColor
        nextLevelLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        nextLevelLabel.layer.shadowRadius = 1
        nextLevelLabel.layer.shadowOpacity = 1.0
        nextLevelLabel.layer.shouldRasterize = true
        nextLevelLabel.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        view.addSubview(nextLevelLabel)
        
        restartButton = UIButton()
        restartButton.alpha = 0
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle(" Restart ", for: .normal)
        restartButton.backgroundColor = UIColor.systemPink
        restartButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
        restartButton.setTitleColor(UIColor.black, for: .normal)
        restartButton.layer.borderColor = UIColor.black.cgColor
        restartButton.layer.borderWidth = 3
        restartButton.layer.cornerRadius = 10
        restartButton.isUserInteractionEnabled = true
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        //shadows {
        restartButton.layer.shadowColor = UIColor.black.cgColor
        restartButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        restartButton.layer.shadowRadius = 1
        restartButton.layer.shadowOpacity = 1.0
        restartButton.layer.shouldRasterize = true
        restartButton.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        view.addSubview(restartButton)
        
        backToMenuButton = UIButton()
        backToMenuButton.alpha = 0
        backToMenuButton.translatesAutoresizingMaskIntoConstraints = false
        backToMenuButton.setTitle(" Menu ", for: .normal)
        backToMenuButton.backgroundColor = UIColor.systemPink
        backToMenuButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
        backToMenuButton.setTitleColor(UIColor.black, for: .normal)
        backToMenuButton.layer.borderColor = UIColor.black.cgColor
        backToMenuButton.layer.borderWidth = 3
        backToMenuButton.layer.cornerRadius = 10
        backToMenuButton.isUserInteractionEnabled = true
        backToMenuButton.addTarget(self, action: #selector(backToMenuButtonTapped), for: .touchUpInside)
        //shadows {
        backToMenuButton.layer.shadowColor = UIColor.black.cgColor
        backToMenuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        backToMenuButton.layer.shadowRadius = 1
        backToMenuButton.layer.shadowOpacity = 1.0
        backToMenuButton.layer.shouldRasterize = true
        backToMenuButton.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        view.addSubview(backToMenuButton)
        
//        setupButtons(rowCounter: 2, columnCounter: 3, widthCounter: 130, heightCounter: 180)
//        setupButtons(rowCounter: 5, columnCounter: 4, widthCounter: 100, heightCounter: 140)
        
        //MARK: - Constraints:
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            flipsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            flipsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            pairsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            pairsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gameOverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameOverLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nextLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextLevelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            restartButton.widthAnchor.constraint(equalToConstant: 150),
            
            backToMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backToMenuButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 10),
            backToMenuButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        loadLevel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    func setGradientBackground() {
       let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
       gradientLayer.colors = [
        UIColor.systemPink.cgColor,
        UIColor.systemOrange.cgColor,
       ]
//       gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//       gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//       gradientLayer.locations = [1,0]
       
       self.view.layer.insertSublayer(gradientLayer, at: 0)
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
    
    //MARK: - setupButtons:
    
    func setupButtons(rowCounter: Int, columnCounter: Int, widthCounter: Int, heightCounter: Int) {
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        for row in 0..<rowCounter {
            for column in 0..<columnCounter {
                cardButton = UIButton(type: .system)
                cardButton.setTitleColor(UIColor.clear, for: .normal)
                cardButton.layer.borderWidth = 3
                cardButton.layer.cornerRadius = 10
                cardButton.layer.borderColor = UIColor.systemBrown.cgColor
                cardButton.tintColor = UIColor.orange
                cardButton.setImage(UIImage(named: "Spider"), for: .normal)
                cardButton.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!)
                cardButton.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                let frame = CGRect(x: column * widthCounter, y: row * heightCounter, width: widthCounter, height: heightCounter)
                cardButton.frame = frame
                
                cardButtons.append(cardButton)
                buttonsView.addSubview(cardButton)
            }
        }
        
        NSLayoutConstraint.activate([
            buttonsView.widthAnchor.constraint(equalToConstant: 400),
            buttonsView.heightAnchor.constraint(equalToConstant: 800),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 3),
            buttonsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            buttonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            ])
    }
    
    //MARK: - LoadLevel:
    
    func loadLevel() {
        timeCounter = 3
        cardCounter = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupTimer()
        }
        
        //sync Kill pulsate animation & isUserInteractionEnabled
        syncDisableAnimation = 1.95
        
        //create card list:
        
        //create pair list:
        pairList = cardList
        
        let shuffledList = cardList.shuffled()
        
        //button names list:
        if cardButtons.count == cardList.count {
            for i in 0..<cardButtons.count {
                cardButtons[i].setTitle(shuffledList[i], for: .normal)
                cardButtons[i].setTitleColor(UIColor.white, for: .normal)               //debug title color
                cardButtons[i].titleLabel?.font = UIFont(name: "Helvetica", size: 10)  //debug title size
            }
        }
    }
    
    //MARK: - updateUI:
    
    func updateUI() {
        DispatchQueue.main.async {
            self.buttonsView.removeFromSuperview()
            self.cardButton.removeFromSuperview()
            self.setupButtons(rowCounter: 5, columnCounter: 4, widthCounter: 100, heightCounter: 140)
        }
    }
    
    //MARK: - nextLevel:
    
    func nextLevel() {
        cardList = ["Bat", "Bat",
                    "Bones", "Bones",
                    "Cauldron", "Cauldron",
                    "Skull", "Skull",
                    "Ghost",  "Ghost",
                    "Pumpkin", "Pumpkin",
                    "Eye", "Eye",
                    "Dracula", "Dracula",
                    "Spider", "Spider",
                    "Cobweb", "Cobweb"
        ]
        print(cardList)
        print(cardList.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.updateUI()
        }
        
        
        //nextLevelLabel animation:
        UIView.animate(withDuration: 0.5, animations:  {
            self.nextLevelLabel.alpha = 1
            self.gameOverLabel.pulsate()
        })
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //invalidateTimer:
            self.timer.invalidate()
            
            self.nextLevelLabel.alpha = 0
            
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
        timer.invalidate()
        //labels animations:
        UIView.animate(withDuration: 0.5, animations:  {
            self.gameOverLabel.alpha = 1
            self.backToMenuButton.alpha = 1
            self.restartButton.alpha = 1
            self.gameOverLabel.pulsate()
        })
        
        UIView.transition(with: backToMenuButton, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        UIView.transition(with: restartButton, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
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
        
        //restart button animation:
        restartButton.spring(sender)
        
        activatedCards.removeAll()
        activatedButtons.removeAll()
        
        loadLevel()
        
        //reset level:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.gameOverLabel.alpha = 0
            self.backToMenuButton.alpha = 0
            self.restartButton.alpha = 0
            self.flipsCounter = 0
            self.pairsCounter = 0
            
            //reset cards color:
            for card in self.cardButtons {
                UIButton.animate(withDuration: 1, animations: {
                    card.alpha = 1
                    card.isEnabled = true
                    card.tintColor = UIColor.systemOrange
                    card.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!).withAlphaComponent(1)
                    card.setImage(UIImage(named: "Spider"), for: .normal)
                })
            }
        }
    }
    
    //MARK: - backToMenuButtonTapped:
    
    @objc func backToMenuButtonTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - cardTapped:
    
    @objc func cardTapped(_ sender: UIButton) {
        
        //flip card:
        if !activatedButtons.contains(sender) {
            guard let imageName = sender.titleLabel?.text else { return }
            
            let image = UIImage(named: imageName)
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
                
                
                //timer to show both cards:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
//                    UIView.transition(with: self.activatedButtons.last!, duration: 1.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//
//                    UIView.transition(with: self.activatedButtons.first!, duration: 1.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + syncDisableAnimation) {
                    //kill pulsate animation:
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
}

