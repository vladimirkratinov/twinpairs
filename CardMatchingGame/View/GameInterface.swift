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
        gameView.backgroundColor = .white
        return gameView
    }()
    
    lazy var hub: UIView = {
        let hub = UIView()
        hub.backgroundColor = UIColor(red: 1.00, green: 0.37, blue: 0.25, alpha: 0.5)
        hub.translatesAutoresizingMaskIntoConstraints = false
        hub.layer.borderWidth = 0
        return hub
    }()
    
    static var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: FigmaKey.backgroundGame.rawValue)
        
        backgroundImageView.backgroundColor = .white
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
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
        woodenBack.alpha = 0
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
        settingsView.layer.borderWidth = 0
        settingsView.layer.cornerRadius = 0
//        settingsView.backgroundColor = UIColor(patternImage: UIImage(named: ImageKey.wood3.rawValue)!)
        settingsView.layer.borderColor = UIColor.black.cgColor
        return settingsView
    }()
    
    lazy var settingsBackground: UIImageView = {
        let settingsBackground = UIImageView(frame: .zero)
        settingsBackground.alpha = 1
        settingsBackground.image = UIImage(named: FigmaKey.settings.rawValue)
        settingsBackground.contentMode = .redraw
        settingsBackground.translatesAutoresizingMaskIntoConstraints = false
        return settingsBackground
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
    
//    lazy var settingsBackground: UILabel = {
//       let settingsBackground = UILabel()
//        settingsBackground.text = "Background"
//        setupSettingsLabels(settingsBackground)
//        return settingsBackground
//    }()
    
    //MARK: - Settings - Buttons:
    
    lazy var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.alpha = 1
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(named: ImageKey.SettingsButton.rawValue), for: .normal)
//        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
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
    
//    lazy var backgroundButton: UIButton = {
//        let backgroundButton = UIButton()
//        backgroundButton.setTitle(" Change ", for: .normal)
//        backgroundButton.backgroundColor = .systemPink
//        setupSettingsButtons(backgroundButton)
//        return backgroundButton
//    }()
    
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
        gameView.addSubview(GameInterface.backgroundImageView)
        gameView.addSubview(buttonsView)
        gameView.addSubview(statisticsView)
        gameView.addSubview(woodenBack)
        gameView.addSubview(plusCoinsAnimationsLabel)
        gameView.addSubview(hub)
        gameView.bringSubviewToFront(hub)
        
        //Inside Settings:
        settingsView.addSubview(settingsMusic)
        settingsView.addSubview(settingsSound)
        settingsView.addSubview(settingsVibration)
//        settingsSound.addSubview(settingsBackground)
        
        settingsView.addSubview(muteMusicButton)
        settingsView.addSubview(muteSoundButton)
        settingsView.addSubview(muteVibrationButton)
//        settingsView.addSubview(backgroundButton)
        
        settingsView.addSubview(settingsBackground)
        settingsView.sendSubviewToBack(settingsBackground)
        
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
//            GameInterface.backgroundImageView.topAnchor.constraint(equalTo: gameView.topAnchor),
//            GameInterface.backgroundImageView.leadingAnchor.constraint(equalTo: gameView.leadingAnchor),
//            GameInterface.backgroundImageView.trailingAnchor.constraint(equalTo: gameView.trailingAnchor),
//            GameInterface.backgroundImageView.bottomAnchor.constraint(equalTo: gameView.bottomAnchor),
            //top level:
            woodenBack.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 60),
            woodenBack.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
            //MARK: - Settings:
            
            settingsView.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 0),
            settingsView.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: 0),
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            settingsView.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
            
            hub.leadingAnchor.constraint(equalTo: gameView.leadingAnchor),
            hub.trailingAnchor.constraint(equalTo: gameView.trailingAnchor),
            hub.topAnchor.constraint(equalTo: gameView.topAnchor, constant: 52),
            hub.widthAnchor.constraint(equalTo: gameView.widthAnchor),
            hub.heightAnchor.constraint(equalToConstant: 53),
            
            settingsBackground.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor),
            settingsBackground.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor),
            settingsBackground.topAnchor.constraint(equalTo: settingsView.topAnchor),
            settingsBackground.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor),
            
            //MARK: - Settings Labels:
            
            settingsMusic.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 60),
            settingsMusic.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 50),
            
            settingsSound.topAnchor.constraint(equalTo: settingsMusic.bottomAnchor, constant: 23),
            settingsSound.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 50),
            
            settingsVibration.topAnchor.constraint(equalTo: settingsSound.bottomAnchor, constant: 23),
            settingsVibration.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 50),
            
            //MARK: - Settings Buttons:
            
            muteMusicButton.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 58),
            muteMusicButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -56),
            muteMusicButton.widthAnchor.constraint(equalToConstant: 77),
            muteMusicButton.heightAnchor.constraint(equalToConstant: 34),
            
            muteSoundButton.topAnchor.constraint(equalTo: muteMusicButton.bottomAnchor, constant: 19),
            muteSoundButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -56),
            muteSoundButton.widthAnchor.constraint(equalToConstant: 77),
            muteSoundButton.heightAnchor.constraint(equalToConstant: 34),
            
            muteVibrationButton.topAnchor.constraint(equalTo: muteSoundButton.bottomAnchor, constant: 19),
            muteVibrationButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -56),
            muteVibrationButton.widthAnchor.constraint(equalToConstant: 77),
            muteVibrationButton.heightAnchor.constraint(equalToConstant: 34),
                        
            rateButton.topAnchor.constraint(equalTo: muteVibrationButton.bottomAnchor, constant: 92),
            rateButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 50),
            rateButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -117),
            rateButton.widthAnchor.constraint(equalToConstant: 130),
            rateButton.heightAnchor.constraint(equalToConstant: 44),
            
            quitButton.topAnchor.constraint(equalTo: muteVibrationButton.bottomAnchor, constant: 92),
            quitButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -52),
            quitButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -117),
            quitButton.widthAnchor.constraint(equalToConstant: 130),
            quitButton.heightAnchor.constraint(equalToConstant: 44),
            
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
            
            coinLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            coinLabel.leadingAnchor.constraint(equalTo: hub.leadingAnchor, constant: 11),
            
            pairsLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            pairsLabel.leadingAnchor.constraint(equalTo: coinLabel.trailingAnchor, constant: 10),
            
//            flipsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
//            flipsLabel.leadingAnchor.constraint(equalTo: pairsLabel.trailingAnchor, constant: 5),
            
            difficultylabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            difficultylabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(lessThanOrEqualTo: difficultylabel.trailingAnchor, constant: 65),

            settingsButton.topAnchor.constraint(equalTo: hub.topAnchor, constant: 6),
            settingsButton.bottomAnchor.constraint(equalTo: hub.bottomAnchor, constant: -6),
            settingsButton.trailingAnchor.constraint(equalTo: hub.trailingAnchor, constant: -14),
            settingsButton.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 6),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    //MARK: - setup Settings Appearence:
    
    func setupSettingsButtons(_ thisButton: UIButton) {
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        thisButton.titleLabel?.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 20)
        thisButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        thisButton.setTitleColor(UIColor.black, for: .normal)
        thisButton.layer.borderColor = UIColor.black.cgColor
        thisButton.layer.borderWidth = 0
        thisButton.layer.cornerRadius = 8
        thisButton.isUserInteractionEnabled = true
        thisButton.layer.shadowColor = UIColor.black.cgColor
        thisButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        thisButton.layer.shadowRadius = 3
        thisButton.layer.shadowOpacity = 1.0
        thisButton.layer.shouldRasterize = true
        thisButton.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupSettingsLabels(_ thisLabel: UILabel) {
        thisLabel.translatesAutoresizingMaskIntoConstraints = false
        thisLabel.textAlignment = .left
//        thisLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 25)
        thisLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
    }
}
