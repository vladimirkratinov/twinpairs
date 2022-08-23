//
//  UIView.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

class GameInterface: UIView {
    let prop = Properties()
    let palette = Palette()
    let defaults = UserDefaults.standard
    
    var flipsCounter: Int = 0 {
        didSet {
            flipsLabel.text = "♠️ \(flipsCounter)"
        }
    }
    var pairsCounter: Int = 0 {
        didSet {
            pairsLabel.text = "🃏 \(pairsCounter)"
        }
    }
    var coins: Int = UserDefaults.standard.integer(forKey: CoinsKey.coins.rawValue) {
        didSet {
            coinLabel.text = "🪙\(coins)"
        }
    }
    var timeCounter: Int = 0 {
        didSet {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .abbreviated

            let formattedString = formatter.string(from: TimeInterval(timeCounter))!
            timeLabel.text = "⏳ \(formattedString)"
            
        }
    }
    
    func secToMinSec(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    //MARK: - Views:
    
    var gameView: UIView = {
        let gameView = UIView()
        gameView.backgroundColor = UIColor.red
        return gameView
    }()
    
    var buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 0
        return buttonsView
    }()
    
    var statisticsView: UIView = {
        let statisticsView = UIView()
        statisticsView.alpha = 0
        statisticsView.layer.borderColor = UIColor.black.cgColor
        statisticsView.layer.borderWidth = 1
        statisticsView.layer.cornerRadius = 10
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        statisticsView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        return statisticsView
    }()
    
    lazy var woodenBack: UIImageView = {
        let woodenBack = UIImageView()
        woodenBack.image = UIImage(named: "woodenLog2.png")
        woodenBack.alpha = 0.5
        woodenBack.translatesAutoresizingMaskIntoConstraints = false
        woodenBack.layer.shadowColor = UIColor.black.cgColor
        woodenBack.layer.shadowOffset = CGSize(width: 5, height: 5)
        woodenBack.layer.shadowRadius = 1
        woodenBack.layer.shadowOpacity = 1.0
        woodenBack.layer.shouldRasterize = true
        woodenBack.layer.rasterizationScale = UIScreen.main.scale
        return woodenBack
    }()
    
    //MARK: - Settings:
    
    lazy var settingsView: UIView = {
        let settingsView = UIView()
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.isHidden = true
        settingsView.alpha = 1
        settingsView.layer.borderWidth = 5
        settingsView.layer.cornerRadius = 20
        settingsView.backgroundColor = UIColor(patternImage: UIImage(named: ImageKey.SettingsBackground.rawValue)!)
        settingsView.layer.borderColor = UIColor.black.cgColor
        return settingsView
    }()
    
    lazy var settingsMusic: UILabel = {
       let settingsMusic = UILabel()
        settingsMusic.translatesAutoresizingMaskIntoConstraints = false
        settingsMusic.textAlignment = .left
        settingsMusic.text = "Music"
        settingsMusic.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 30)
        return settingsMusic
    }()
    
    lazy var settingsSound: UILabel = {
       let settingsSound = UILabel()
        settingsSound.translatesAutoresizingMaskIntoConstraints = false
        settingsSound.textAlignment = .left
        settingsSound.text = "Sound"
        settingsSound.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 30)
        return settingsSound
    }()
    
    lazy var settingsVibration: UILabel = {
       let settingsVibration = UILabel()
        settingsVibration.translatesAutoresizingMaskIntoConstraints = false
        settingsVibration.textAlignment = .left
        settingsVibration.text = "Vibration"
        settingsVibration.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 30)
        return settingsVibration
    }()

    lazy var muteMusicButton: UIButton = {
        let muteMusicButton = UIButton()
        let defaults = UserDefaults.standard
        muteMusicButton.alpha = 1
        muteMusicButton.translatesAutoresizingMaskIntoConstraints = false
        muteMusicButton.setTitle(" Mute ", for: .normal)
        muteMusicButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        muteMusicButton.setTitleColor(UIColor.black, for: .normal)
        muteMusicButton.layer.borderColor = UIColor.black.cgColor
        muteMusicButton.layer.borderWidth = 3
        muteMusicButton.layer.cornerRadius = 10
        muteMusicButton.isUserInteractionEnabled = true
        muteMusicButton.backgroundColor = defaults.colorForKey(key: ColorKey.musicButton.rawValue) ?? UIColor.systemPink
        muteMusicButton.layer.shadowColor = UIColor.black.cgColor
        muteMusicButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        muteMusicButton.layer.shadowRadius = 1
        muteMusicButton.layer.shadowOpacity = 1.0
        muteMusicButton.layer.shouldRasterize = true
        muteMusicButton.layer.rasterizationScale = UIScreen.main.scale
        return muteMusicButton
    }()
    
    lazy var muteSoundButton: UIButton = {
        let muteSoundButton = UIButton()
        let defaults = UserDefaults.standard
        muteSoundButton.alpha = 1
        muteSoundButton.translatesAutoresizingMaskIntoConstraints = false
        muteSoundButton.setTitle(" Mute ", for: .normal)
        muteSoundButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        muteSoundButton.setTitleColor(UIColor.black, for: .normal)
        muteSoundButton.layer.borderColor = UIColor.black.cgColor
        muteSoundButton.layer.borderWidth = 3
        muteSoundButton.layer.cornerRadius = 10
        muteSoundButton.isUserInteractionEnabled = true
        muteSoundButton.backgroundColor = defaults.colorForKey(key: ColorKey.soundButton.rawValue) ?? UIColor.systemPink
        muteSoundButton.layer.shadowColor = UIColor.black.cgColor
        muteSoundButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        muteSoundButton.layer.shadowRadius = 1
        muteSoundButton.layer.shadowOpacity = 1.0
        muteSoundButton.layer.shouldRasterize = true
        muteSoundButton.layer.rasterizationScale = UIScreen.main.scale
        return muteSoundButton
    }()
    
    lazy var muteVibrationButton: UIButton = {
        let muteVibrationButton = UIButton()
        let defaults = UserDefaults.standard
        muteVibrationButton.alpha = 0.3
        muteVibrationButton.translatesAutoresizingMaskIntoConstraints = false
        muteVibrationButton.setTitle(" Mute ", for: .normal)
        muteVibrationButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        muteVibrationButton.setTitleColor(UIColor.black, for: .normal)
        muteVibrationButton.layer.borderColor = UIColor.black.cgColor
        muteVibrationButton.layer.borderWidth = 3
        muteVibrationButton.layer.cornerRadius = 10
        muteVibrationButton.isUserInteractionEnabled = true
        muteVibrationButton.backgroundColor = defaults.colorForKey(key: ColorKey.vibrationButton.rawValue) ?? UIColor.systemPink
        muteVibrationButton.layer.shadowColor = UIColor.black.cgColor
        muteVibrationButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        muteVibrationButton.layer.shadowRadius = 1
        muteVibrationButton.layer.shadowOpacity = 1.0
        muteVibrationButton.layer.shouldRasterize = true
        muteVibrationButton.layer.rasterizationScale = UIScreen.main.scale
        return muteVibrationButton
    }()
    
    lazy var quitButton: UIButton = {
        let quitButton = UIButton()
        quitButton.alpha = 1
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.setTitle(" Quit ", for: .normal)
        quitButton.backgroundColor = UIColor.systemPink
        quitButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        quitButton.setTitleColor(UIColor.black, for: .normal)
        quitButton.layer.borderColor = UIColor.black.cgColor
        quitButton.layer.borderWidth = 3
        quitButton.layer.cornerRadius = 10
        quitButton.isUserInteractionEnabled = true
        quitButton.layer.shadowColor = UIColor.black.cgColor
        quitButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        quitButton.layer.shadowRadius = 1
        quitButton.layer.shadowOpacity = 1.0
        quitButton.layer.shouldRasterize = true
        quitButton.layer.rasterizationScale = UIScreen.main.scale
        return quitButton
    }()
    
    lazy var rateButton: UIButton = {
        let rateButton = UIButton()
        rateButton.alpha = 0.3
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        rateButton.setTitle(" Rate Us ", for: .normal)
        rateButton.backgroundColor = UIColor.systemGreen
        rateButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        rateButton.setTitleColor(UIColor.black, for: .normal)
        rateButton.layer.borderColor = UIColor.black.cgColor
        rateButton.layer.borderWidth = 3
        rateButton.layer.cornerRadius = 10
        rateButton.isUserInteractionEnabled = true
        rateButton.layer.shadowColor = UIColor.black.cgColor
        rateButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        rateButton.layer.shadowRadius = 1
        rateButton.layer.shadowOpacity = 1.0
        rateButton.layer.shouldRasterize = true
        rateButton.layer.rasterizationScale = UIScreen.main.scale
        return rateButton
    }()
    
    //MARK: - UI Labels:

    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = Properties.uiLabelsColor
        timeLabel.textAlignment = .left
        timeLabel.text = ""
        timeLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return timeLabel
    }()
    
    var coinLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.textColor = Properties.uiLabelsColor
        coinLabel.textAlignment = .left
        coinLabel.text = "🪙 \(UserDefaults.standard.integer(forKey: CoinsKey.coins.rawValue))"
        coinLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return coinLabel
    }()
    
    var pairsLabel: UILabel = {
        let pairsLabel = UILabel()
        pairsLabel.translatesAutoresizingMaskIntoConstraints = false
        pairsLabel.textColor = Properties.uiLabelsColor
        pairsLabel.textAlignment = .right
        pairsLabel.text = "🃏 0"
        pairsLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return pairsLabel
    }()

    var flipsLabel: UILabel = {
        let flipsLabel = UILabel()
        flipsLabel.translatesAutoresizingMaskIntoConstraints = false
        flipsLabel.textColor = Properties.uiLabelsColor
        flipsLabel.textAlignment = .right
        flipsLabel.text = "♠️ 0"
        flipsLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return flipsLabel
    }()
    
    //MARK: - Statistics Label:
    
    lazy var statisticsLabel: UILabel = {
        let statisticsLabel = UILabel()
        statisticsLabel.alpha = 1
        statisticsLabel.translatesAutoresizingMaskIntoConstraints = false
        statisticsLabel.textAlignment = .center
        statisticsLabel.numberOfLines = 5
        statisticsLabel.text = "statistics"
        statisticsLabel.textColor = UIColor.gray
        statisticsLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        return statisticsLabel
    }()
    
    lazy var bestResultLabel: UILabel = {
        let bestResultLabel = UILabel()
        bestResultLabel.alpha = 1
        bestResultLabel.translatesAutoresizingMaskIntoConstraints = false
        bestResultLabel.textColor = UIColor.darkGray
        bestResultLabel.textAlignment = .center
        bestResultLabel.numberOfLines = 5
        bestResultLabel.text = "best results"
        bestResultLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        return bestResultLabel
    }()

    //MARK: - Pop-up Label:
    
    lazy var gameOverLabel: UILabel = {
        let gameOverLabel = UILabel()
        gameOverLabel.alpha = 0
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "GAME OVER!"
        gameOverLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 55)
        gameOverLabel.textColor = UIColor.yellow
        gameOverLabel.layer.shadowColor = UIColor.black.cgColor
        gameOverLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        gameOverLabel.layer.shadowRadius = 1
        gameOverLabel.layer.shadowOpacity = 1.0
        gameOverLabel.layer.shouldRasterize = true
        gameOverLabel.layer.rasterizationScale = UIScreen.main.scale
        return gameOverLabel
    }()

    lazy var nextLevelLabel: UILabel = {
        let nextLevelLabel = UILabel()
        nextLevelLabel.alpha = 0
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        nextLevelLabel.textAlignment = .center
        nextLevelLabel.text = "NEXT LEVEL!"
        nextLevelLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 45)
        nextLevelLabel.textColor = UIColor.green
        nextLevelLabel.layer.shadowColor = UIColor.black.cgColor
        nextLevelLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        nextLevelLabel.layer.shadowRadius = 1
        nextLevelLabel.layer.shadowOpacity = 1.0
        nextLevelLabel.layer.shouldRasterize = true
        nextLevelLabel.layer.rasterizationScale = UIScreen.main.scale
        return nextLevelLabel
    }()
    
    lazy var plusCoinsAnimationsLabel: UILabel = {
        let plusCoinsAnimationsLabel = UILabel()
        plusCoinsAnimationsLabel.alpha = 0
        plusCoinsAnimationsLabel.translatesAutoresizingMaskIntoConstraints = false
        plusCoinsAnimationsLabel.textAlignment = .center
        plusCoinsAnimationsLabel.text = "+1 Coin!"
        plusCoinsAnimationsLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        plusCoinsAnimationsLabel.textColor = UIColor.yellow
        plusCoinsAnimationsLabel.layer.shadowColor = UIColor.black.cgColor
        plusCoinsAnimationsLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        plusCoinsAnimationsLabel.layer.shadowRadius = 1
        plusCoinsAnimationsLabel.layer.shadowOpacity = 1.0
        plusCoinsAnimationsLabel.layer.shouldRasterize = true
        plusCoinsAnimationsLabel.layer.rasterizationScale = UIScreen.main.scale
        return plusCoinsAnimationsLabel
    }()
    
    //MARK: - Buttons:
    
    lazy var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.alpha = 1
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(named: ImageKey.SettingsButton.rawValue), for: .normal)
        settingsButton.isUserInteractionEnabled = true
        settingsButton.layer.shadowColor = UIColor.black.cgColor
        settingsButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        settingsButton.layer.shadowRadius = 1
        settingsButton.layer.shadowOpacity = 1.0
        settingsButton.layer.shouldRasterize = true
        settingsButton.layer.rasterizationScale = UIScreen.main.scale
        return settingsButton
    }()
    
    lazy var restartButton: UIButton = {
        let restartButton = UIButton()
        restartButton.alpha = 0
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle(" Restart ", for: .normal)
        restartButton.backgroundColor = UIColor.red
        restartButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        restartButton.setTitleColor(UIColor.black, for: .normal)
        restartButton.layer.borderColor = UIColor.black.cgColor
        restartButton.layer.borderWidth = 3
        restartButton.layer.cornerRadius = 10
        restartButton.isUserInteractionEnabled = true
        return restartButton
    }()

    lazy var backToMenuButton: UIButton = {
        let backToMenuButton = UIButton()
        backToMenuButton.isHidden = false
        backToMenuButton.alpha = 0
        backToMenuButton.translatesAutoresizingMaskIntoConstraints = false
        backToMenuButton.setTitle(" Menu ", for: .normal)
        backToMenuButton.backgroundColor = UIColor.systemPink
        backToMenuButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        backToMenuButton.setTitleColor(UIColor.black, for: .normal)
        backToMenuButton.layer.borderColor = UIColor.black.cgColor
        backToMenuButton.layer.borderWidth = 3
        backToMenuButton.layer.cornerRadius = 10
        backToMenuButton.isUserInteractionEnabled = true
        backToMenuButton.layer.shadowColor = UIColor.black.cgColor
        backToMenuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        backToMenuButton.layer.shadowRadius = 1
        backToMenuButton.layer.shadowOpacity = 1.0
        backToMenuButton.layer.shouldRasterize = true
        backToMenuButton.layer.rasterizationScale = UIScreen.main.scale
        return backToMenuButton
    }()
    
    //MARK: - Subview:
    
    func setupSubviews() {
        //Views:
        gameView.addSubview(buttonsView)
        gameView.addSubview(statisticsView)
        gameView.addSubview(woodenBack)
        gameView.addSubview(plusCoinsAnimationsLabel)
        
        //Inside Settings:
        settingsView.addSubview(settingsMusic)
        settingsView.addSubview(settingsSound)
        settingsView.addSubview(settingsVibration)
        
        settingsView.addSubview(muteMusicButton)
        settingsView.addSubview(muteSoundButton)
        settingsView.addSubview(muteVibrationButton)
        
        settingsView.addSubview(quitButton)
        settingsView.addSubview(rateButton)
        
        //UI:
        gameView.addSubview(timeLabel)
        gameView.addSubview(coinLabel)
//        gameView.addSubview(flipsLabel)
        gameView.addSubview(pairsLabel)
        gameView.addSubview(settingsButton)
        
        //statistics:
        statisticsView.addSubview(bestResultLabel)
        statisticsView.addSubview(statisticsLabel)
        
        //pop-up:
        gameView.addSubview(gameOverLabel)
        gameView.addSubview(nextLevelLabel)
        
        gameView.addSubview(restartButton)
        gameView.addSubview(backToMenuButton)
        
        //Settings:
        gameView.addSubview(settingsView)
        gameView.bringSubviewToFront(settingsView)
    }
    
    //MARK: - Constraints:
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //top level:
            woodenBack.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 60),
            woodenBack.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
            //settings:
            settingsView.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 30),
            settingsView.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: -30),
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            settingsView.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
            
            settingsMusic.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            settingsMusic.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            
            settingsSound.topAnchor.constraint(equalTo: settingsMusic.bottomAnchor, constant: 20),
            settingsSound.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            
            settingsVibration.topAnchor.constraint(equalTo: settingsSound.bottomAnchor, constant: 20),
            settingsVibration.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),

            muteMusicButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteMusicButton.topAnchor.constraint(equalTo: settingsMusic.topAnchor, constant: 0),
            muteMusicButton.widthAnchor.constraint(equalToConstant: 80),
            
            muteSoundButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteSoundButton.topAnchor.constraint(equalTo: settingsSound.topAnchor, constant: 0),
            muteSoundButton.widthAnchor.constraint(equalToConstant: 80),
            
            muteVibrationButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteVibrationButton.topAnchor.constraint(equalTo: settingsVibration.topAnchor, constant: 0),
            muteVibrationButton.widthAnchor.constraint(equalToConstant: 80),
            
            quitButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            quitButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20),
            quitButton.widthAnchor.constraint(equalToConstant: 100),
            
            rateButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            rateButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20),
            rateButton.widthAnchor.constraint(equalToConstant: 100),
            
            //Views:
            buttonsView.topAnchor.constraint(equalTo: woodenBack.bottomAnchor, constant: 0),
            buttonsView.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: gameView.layoutMarginsGuide.bottomAnchor, constant: -40),
            
            statisticsView.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 5),
            statisticsView.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 20),
            statisticsView.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -20),
            statisticsView.bottomAnchor.constraint(equalTo: bestResultLabel.bottomAnchor, constant: 10),
            
            statisticsLabel.topAnchor.constraint(equalTo: statisticsView.topAnchor, constant: 10),
            statisticsLabel.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor),

            bestResultLabel.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 0),
            bestResultLabel.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor),
            
            //UI:
            pairsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            pairsLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor, constant: 5),
            
//            flipsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
//            flipsLabel.leadingAnchor.constraint(equalTo: pairsLabel.trailingAnchor, constant: 5),
            
            coinLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: pairsLabel.trailingAnchor, constant: 10),

            timeLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -10),
            
            settingsButton.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor, constant: -10),
            settingsButton.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            //Pop-up:
            gameOverLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            gameOverLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),

            nextLevelLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            nextLevelLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),

            restartButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: gameView.centerYAnchor, constant: 100),
            restartButton.widthAnchor.constraint(equalToConstant: 120),

            backToMenuButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            backToMenuButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 10),
            backToMenuButton.widthAnchor.constraint(equalToConstant: 120),
            
            //Animations:
            plusCoinsAnimationsLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            plusCoinsAnimationsLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
        ])
    }
    
    //MARK: - Set Gradient Bachround:
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gameView.bounds
        gradientLayer.colors = [
            
//            UIColor.systemPink.cgColor,
//            UIColor.systemOrange.cgColor,
//            UIColor.systemRed.cgColor
            
//            UIColor.systemGreen.cgColor,
//            UIColor.systemTeal.cgColor,
//            UIColor.systemBrown.cgColor
            
//            UIColor.systemBlue.cgColor,
//            UIColor.systemGray.cgColor,
//            UIColor.systemBrown.cgColor,
            
            palette.wildCarribeanGrean.cgColor,
            palette.darkMountainMeadow.cgColor,
            palette.fuelTown.cgColor,
            
        ]
        gameView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
