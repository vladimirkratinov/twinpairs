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
    var coins: Int = Properties.coins {
        didSet {
            coinLabel.text = "🪙 \(coins)"
        }
    }
    var timeCounter: Int = 0 {
        didSet {
//            let formatter = DateComponentsFormatter()
//            formatter.allowedUnits = [.hour, .minute, .second]
//            formatter.unitsStyle = .abbreviated
//            let formattedString = formatter.string(from: TimeInterval(timeCounter))!
            
            let convertedTime = secToMinSec(timeCounter)
            let minutes = convertedTime.0
            let seconds = convertedTime.1
            var secondZero = ""
            
            if seconds == 0 {
                secondZero = "0"
            } else {
                secondZero.removeAll()
            }
            timeLabel.text = "⏳ \(minutes):\(seconds)\(secondZero)"
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
    
    //MARK: - UI Labels:

    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = Properties.uiLabelsColor
        timeLabel.textAlignment = .left
        timeLabel.text = ""
        timeLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return timeLabel
    }()
    
    var difficultylabel: UILabel = {
        let difficultylabel = UILabel()
        difficultylabel.translatesAutoresizingMaskIntoConstraints = false
        difficultylabel.textColor = Properties.uiLabelsColor
        difficultylabel.textAlignment = .center
        difficultylabel.text = Properties.selectedDifficulty
        difficultylabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return difficultylabel
    }()
    
    var coinLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.textColor = Properties.uiLabelsColor
        coinLabel.textAlignment = .left
        coinLabel.text = "🪙 \(Properties.coins)"
        coinLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return coinLabel
    }()
    
    var pairsLabel: UILabel = {
        let pairsLabel = UILabel()
        pairsLabel.translatesAutoresizingMaskIntoConstraints = false
        pairsLabel.textColor = Properties.uiLabelsColor
        pairsLabel.textAlignment = .right
        pairsLabel.text = "🃏 0"
        pairsLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return pairsLabel
    }()

    var flipsLabel: UILabel = {
        let flipsLabel = UILabel()
        flipsLabel.translatesAutoresizingMaskIntoConstraints = false
        flipsLabel.textColor = Properties.uiLabelsColor
        flipsLabel.textAlignment = .right
        flipsLabel.text = "♠️ 0"
        flipsLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
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
        gameOverLabel.text = "GAME OVER"
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
        nextLevelLabel.text = "GREAT!"
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
        plusCoinsAnimationsLabel.text = "+2 Coins"
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
    
    //MARK: - Settings:
    
    lazy var settingsView: UIView = {
        let settingsView = UIView()
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.isHidden = true
        settingsView.alpha = 1
        settingsView.layer.borderWidth = 5
        settingsView.layer.cornerRadius = 20
        settingsView.backgroundColor = UIColor(patternImage: UIImage(named: ImageKey.wood3.rawValue)!)
        settingsView.layer.borderColor = UIColor.black.cgColor
        return settingsView
    }()
    
    //MARK: - Settings - Labels:
    
    lazy var settingsMusic: UILabel = {
       let settingsMusic = UILabel()
        settingsMusic.text = "Music"
        setupSettingsLabels(settingsMusic)
        return settingsMusic
    }()
    
    lazy var settingsSound: UILabel = {
       let settingsSound = UILabel()
        settingsSound.text = "Sound"
        setupSettingsLabels(settingsSound)
        return settingsSound
    }()
    
    lazy var settingsVibration: UILabel = {
       let settingsVibration = UILabel()
        settingsVibration.text = "Vibration"
        setupSettingsLabels(settingsVibration)
        return settingsVibration
    }()
    
    lazy var settingsBackground: UILabel = {
       let settingsBackground = UILabel()
        settingsBackground.text = "Background"
        setupSettingsLabels(settingsBackground)
        return settingsBackground
    }()
    
    //MARK: - Settings - Buttons:
    
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

    lazy var muteMusicButton: UIButton = {
        let muteMusicButton = UIButton()
        muteMusicButton.setTitle(" Mute ", for: .normal)
        muteMusicButton.backgroundColor = Properties.defaultMusicButtonColor
        setupSettingsButtons(muteMusicButton)
        return muteMusicButton
    }()
    
    lazy var muteSoundButton: UIButton = {
        let muteSoundButton = UIButton()
        muteSoundButton.setTitle(" Mute ", for: .normal)
        muteSoundButton.backgroundColor = Properties.defaultSoundButtonColor
        setupSettingsButtons(muteSoundButton)
        return muteSoundButton
    }()
    
    lazy var muteVibrationButton: UIButton = {
        let muteVibrationButton = UIButton()
        muteVibrationButton.setTitle(" Mute ", for: .normal)
        muteVibrationButton.backgroundColor = Properties.defaultVibroButtonColor
        setupSettingsButtons(muteVibrationButton)
        return muteVibrationButton
    }()
    
    lazy var backgroundButton: UIButton = {
        let backgroundButton = UIButton()
        backgroundButton.setTitle(" Change ", for: .normal)
        backgroundButton.backgroundColor = .green
        setupSettingsButtons(backgroundButton)
        return backgroundButton
    }()
    
    lazy var quitButton: UIButton = {
        let quitButton = UIButton()
        quitButton.setTitle(" Quit ", for: .normal)
        setupSettingsButtons(quitButton)
        quitButton.backgroundColor = .systemPink
        return quitButton
    }()
    
    lazy var rateButton: UIButton = {
        let rateButton = UIButton()
        rateButton.setTitle(" Rate Us ", for: .normal)
        setupSettingsButtons(rateButton)
        rateButton.alpha = 0.3
        rateButton.backgroundColor = .systemGreen
        return rateButton
    }()
    
   
    lazy var restartButton: UIButton = {
        let restartButton = UIButton()
        restartButton.alpha = 0
        restartButton.isHidden = true
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle(" Restart ", for: .normal)
        restartButton.backgroundColor = UIColor.systemPink
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
        backToMenuButton.setTitle(" Menu ", for: .normal)
        setupSettingsButtons(backToMenuButton)
        backToMenuButton.backgroundColor = .systemPink
        backToMenuButton.alpha = 0
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
        settingsSound.addSubview(settingsBackground)
        
        settingsView.addSubview(muteMusicButton)
        settingsView.addSubview(muteSoundButton)
        settingsView.addSubview(muteVibrationButton)
        settingsView.addSubview(backgroundButton)
        
        settingsView.addSubview(quitButton)
        settingsView.addSubview(rateButton)
        
        //UI:
        gameView.addSubview(timeLabel)
        gameView.addSubview(coinLabel)
        gameView.addSubview(difficultylabel)
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
            
            settingsBackground.topAnchor.constraint(equalTo: settingsVibration.bottomAnchor, constant: 20),
            settingsBackground.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),

            muteMusicButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteMusicButton.topAnchor.constraint(equalTo: settingsMusic.topAnchor, constant: 0),
            muteMusicButton.widthAnchor.constraint(equalToConstant: 80),
            
            muteSoundButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteSoundButton.topAnchor.constraint(equalTo: settingsSound.topAnchor, constant: 0),
            muteSoundButton.widthAnchor.constraint(equalToConstant: 80),
            
            muteVibrationButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            muteVibrationButton.topAnchor.constraint(equalTo: settingsVibration.topAnchor, constant: 0),
            muteVibrationButton.widthAnchor.constraint(equalToConstant: 80),
            
            backgroundButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            backgroundButton.topAnchor.constraint(equalTo: settingsBackground.topAnchor, constant: 0),
            backgroundButton.widthAnchor.constraint(equalToConstant: 80),
            
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
            
            //OLD COINS & PAIRS:
//            coinLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
//            coinLabel.leadingAnchor.constraint(equalTo: pairsLabel.trailingAnchor, constant: 10),
//
//            pairsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
//            pairsLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor, constant: 5),
            
            //NEW COINS & PAIRS:
            
            coinLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor, constant: 5),
            
            pairsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            pairsLabel.leadingAnchor.constraint(equalTo: coinLabel.trailingAnchor, constant: 10),
            
//            flipsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
//            flipsLabel.leadingAnchor.constraint(equalTo: pairsLabel.trailingAnchor, constant: 5),
            
            difficultylabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            difficultylabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
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
            backToMenuButton.centerYAnchor.constraint(equalTo: gameView.centerYAnchor, constant: 100),
//            backToMenuButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 10),
            backToMenuButton.widthAnchor.constraint(equalToConstant: 120),
            
            //Animations:
            plusCoinsAnimationsLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            plusCoinsAnimationsLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
        ])
    }
    
    //MARK: - Set Gradient Bachround:
    
    func setGradientBackground1() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gameView.bounds
        gradientLayer.colors = [
            palette.wildCarribeanGrean.cgColor,
            palette.darkMountainMeadow.cgColor,
            palette.fuelTown.cgColor,
        ]
        gameView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground2() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gameView.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor,
            UIColor.systemRed.cgColor,
        ]
        gameView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground3() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gameView.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemGray.cgColor,
            UIColor.systemBrown.cgColor,
        ]
        gameView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - setup Settings Appearence:
    
    func setupSettingsButtons(_ thisButton: UIButton) {
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisButton.titleLabel?.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 20)
        thisButton.setTitleColor(UIColor.black, for: .normal)
        thisButton.layer.borderColor = UIColor.black.cgColor
        thisButton.layer.borderWidth = 3
        thisButton.layer.cornerRadius = 10
        thisButton.isUserInteractionEnabled = true
        thisButton.layer.shadowColor = UIColor.black.cgColor
        thisButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        thisButton.layer.shadowRadius = 1
        thisButton.layer.shadowOpacity = 1.0
        thisButton.layer.shouldRasterize = true
        thisButton.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupSettingsLabels(_ thisLabel: UILabel) {
        thisLabel.translatesAutoresizingMaskIntoConstraints = false
        thisLabel.textAlignment = .left
        thisLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 30)
    }
}
