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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0.5
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "settings"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 96)
        return label
    }()
    
    lazy var titleTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0.5
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "(tap to dismiss)"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
        return label
    }()
    
    var flipsCounter: Int = 0 {
        didSet {
            flipsLabel.text = "♠️ \(flipsCounter)"
//            Properties.statisticsFlipsCounter = flipsCounter
        }
    }
    var pairsCounter: Int = 0 {
        didSet {
            pairsLabel.text = "🃏 \(pairsCounter)"
//            Properties.statisticsPairsCounter = pairsCounter
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
            var firstZero = ""
            
            if seconds == 0 {
                secondZero = "0"
            } else {
                secondZero.removeAll()
            }
            
            if seconds < 10 && seconds != 0 {
                firstZero = "0"
            } else {
                firstZero.removeAll()
            }
            timeLabel.text = "⏳ \(minutes):\(firstZero)\(seconds)\(secondZero)"
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
//        hub.backgroundColor = UIColor(red: 1.00, green: 0.37, blue: 0.25, alpha: 0.5) //orange
        hub.backgroundColor = UIColor(red: 0.06, green: 0.67, blue: 0.52, alpha: 0.5)
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
    
    //MARK: - GameOverView:
    
    lazy var gameOverView: UIView = {
        let gameOverView = UIView()
        gameOverView.alpha = 0
        gameOverView.layer.borderColor = UIColor.black.cgColor
        gameOverView.layer.borderWidth = 0
        gameOverView.layer.cornerRadius = 0
        gameOverView.translatesAutoresizingMaskIntoConstraints = false
        gameOverView.backgroundColor = UIColor(patternImage: UIImage(named: FigmaKey.backgroundGameOver.rawValue)!)
        return gameOverView
    }()
    
    lazy var statisticsView: UIView = {
        let statisticsView = UIView()
        statisticsView.alpha = 1
        statisticsView.layer.borderColor = UIColor.black.cgColor
        statisticsView.layer.borderWidth = 0
        statisticsView.layer.cornerRadius = 10
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        statisticsView.backgroundColor = UIColor(red: 0.82, green: 0.75, blue: 0.75, alpha: 0.9)
        return statisticsView
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    lazy var verticalCentralSeparatorLine: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    lazy var verticalLeftSeparatorLine: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    lazy var verticalRightSeparatorLine: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    lazy var verticalLeftPart: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var verticalRightPart: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var horizontalUpPart: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var horizontalDownPart: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var horizontalUpSeparatorLine: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    lazy var horizontalDownSeparatorLine: UIView = {
        let view = UIView()
        view.alpha = Properties.debugGameOverStatisticsViewAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        return view
    }()
    
    
    lazy var gameOverLabel: UILabel = {
        let gameOverLabel = UILabel()
        gameOverLabel.alpha = 0
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "game over"
        gameOverLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 96)
        gameOverLabel.textColor = UIColor(red: 0.85, green: 0.95, blue: 0.63, alpha: 1.00)
        gameOverLabel.layer.shadowColor = UIColor.black.cgColor
        gameOverLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        gameOverLabel.layer.shadowRadius = 1
        gameOverLabel.layer.shadowOpacity = 1.0
        gameOverLabel.layer.shouldRasterize = true
        gameOverLabel.layer.rasterizationScale = UIScreen.main.scale
        return gameOverLabel
    }()
    
    lazy var yourResultLabel: UILabel = {
        let yourResultLabel = UILabel()
        yourResultLabel.alpha = 1
        yourResultLabel.translatesAutoresizingMaskIntoConstraints = false
        yourResultLabel.textAlignment = .center
        yourResultLabel.text = "your result"
        yourResultLabel.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        yourResultLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 55)
        return yourResultLabel
    }()
    
    lazy var bestResultLabel: UILabel = {
        let bestResultLabel = UILabel()
        bestResultLabel.alpha = 1
        bestResultLabel.translatesAutoresizingMaskIntoConstraints = false
        bestResultLabel.textAlignment = .center
        bestResultLabel.text = "best result"
        bestResultLabel.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        bestResultLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 55)
        return bestResultLabel
    }()
    
    //MARK: - Your Results Labels:
    
    lazy var yourResultTimeLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "time"
        label.addSystemImage(imageName: "clock")
        return label
    }()

    lazy var yourResultPairsLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "pairs"
        label.addSystemImage(imageName: "person.2")
        return label
    }()

    lazy var yourResultFlipsLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "flips"
        label.addSystemImage(imageName: "hand.draw")
        return label
    }()

    lazy var yourResultScoreLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "score"
        label.addSystemImage(imageName: "hands.sparkles")
        return label
    }()
    
    //MARK: - Your Results Views:
    
    lazy var yourResultTimeView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var yourResultPairsView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var yourResultFlipsView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var yourResultScoreView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    //MARK: - Your Results Views Labels:
    
    lazy var yourResultTimeViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        label.text = "0"
        return label
    }()
    
    lazy var yourResultPairsViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        label.text = "0"
        return label
    }()
    
    lazy var yourResultFlipsViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        label.text = "0"
        return label
    }()
    
    lazy var yourResultScoreViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        label.text = "n/a"
        return label
    }()
    
    
    //MARK: - Best Results Labels:
    
    lazy var bestResultTimeLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "time"
        label.addSystemImage(imageName: "clock")
        return label
    }()

    lazy var bestResultPairsLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "pairs"
        label.addSystemImage(imageName: "person.2")
        return label
    }()

    lazy var bestResultFlipsLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "flips"
        label.addSystemImage(imageName: "hand.draw")
        return label
    }()

    lazy var bestResultScoreLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabels(label)
        label.text = "score"
        label.addSystemImage(imageName: "hands.sparkles")
        return label
    }()
    
    //MARK: - Best Results Views:
    
    lazy var bestResultTimeView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var bestResultPairsView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var bestResultFlipsView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    lazy var bestResultScoreView: UIView = {
        let view = UIView()
        setupStatisticsViews(view)
        return view
    }()
    
    //MARK: - Best Results Views Labels:
    
    lazy var bestResultTimeViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        return label
    }()
    
    lazy var bestResultPairsViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        return label
    }()
    
    lazy var bestResultFlipsViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        return label
    }()
    
    lazy var bestResultScoreViewLabel: UILabel = {
        let label = UILabel()
        setupStatisticsLabelsInsideViews(label)
        return label
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
    

    //MARK: - Pop-up Label:

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
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle(Properties.defaultMusicButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultMusicButtonColor
//        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
    }()
    
    lazy var muteSoundButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultSoundButtonColor
//        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
    }()
    
    lazy var muteVibrationButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle(Properties.defaultVibrationButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultVibroButtonColor
//        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
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
        quitButton.setTitle("menu", for: .normal)
        setupSettingsButtons(quitButton)
        quitButton.backgroundColor = .systemPink
        return quitButton
    }()
    
    lazy var rateButton: UIButton = {
        let rateButton = UIButton()
        rateButton.setTitle("game over", for: .normal)
        rateButton.titleLabel?.adjustsFontSizeToFitWidth = true
        setupSettingsButtons(rateButton)
        rateButton.alpha = 1
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

    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setTitle("back", for: .normal)
        setupSettingsButtons(button)
        button.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.63, alpha: 1.00)
        button.alpha = 0
        return button
    }()
    
    //MARK: - Subview:
    
    func setupSubviews() {
        //Views:
        gameView.addSubview(GameInterface.backgroundImageView)
        gameView.addSubview(buttonsView)
        gameView.addSubview(gameOverView)
        gameView.addSubview(woodenBack)
        gameView.addSubview(plusCoinsAnimationsLabel)
        gameView.addSubview(hub)
        gameView.bringSubviewToFront(hub)
        
        //Inside Settings:
        settingsView.addSubview(settingsMusic)
        settingsView.addSubview(settingsSound)
        settingsView.addSubview(settingsVibration)
        settingsView.addSubview(muteMusicButton)
        settingsView.addSubview(muteSoundButton)
        settingsView.addSubview(muteVibrationButton)
        settingsView.addSubview(settingsBackground)
        settingsView.sendSubviewToBack(settingsBackground)
        settingsView.addSubview(titleLabel)
        settingsView.addSubview(titleTipLabel)
        settingsView.addSubview(quitButton)
        settingsView.addSubview(rateButton)
        
        //UI:
        gameView.addSubview(timeLabel)
        gameView.addSubview(coinLabel)
        gameView.addSubview(difficultylabel)
        gameView.addSubview(pairsLabel)
        gameView.addSubview(settingsButton)
        
        //statistics:
        gameOverView.addSubview(gameOverLabel)
        gameOverView.addSubview(statisticsView)
        
        statisticsView.addSubview(yourResultLabel)
        statisticsView.addSubview(bestResultLabel)
        statisticsView.addSubview(separatorLine)
        statisticsView.addSubview(verticalCentralSeparatorLine)
        statisticsView.addSubview(verticalLeftSeparatorLine)
        statisticsView.addSubview(verticalRightSeparatorLine)
        statisticsView.addSubview(verticalLeftPart)
        statisticsView.addSubview(verticalRightPart)
        statisticsView.addSubview(horizontalUpPart)
        statisticsView.addSubview(horizontalDownPart)
        statisticsView.addSubview(horizontalUpSeparatorLine)
        statisticsView.addSubview(horizontalDownSeparatorLine)
        
        statisticsView.addSubview(yourResultTimeLabel)
        statisticsView.addSubview(yourResultPairsLabel)
        statisticsView.addSubview(yourResultFlipsLabel)
        statisticsView.addSubview(yourResultScoreLabel)
        
        statisticsView.addSubview(yourResultTimeView)
        statisticsView.addSubview(yourResultPairsView)
        statisticsView.addSubview(yourResultFlipsView)
        statisticsView.addSubview(yourResultScoreView)
        
        statisticsView.addSubview(yourResultTimeViewLabel)
        statisticsView.addSubview(yourResultPairsViewLabel)
        statisticsView.addSubview(yourResultFlipsViewLabel)
        statisticsView.addSubview(yourResultScoreViewLabel)
        
        statisticsView.addSubview(bestResultTimeLabel)
        statisticsView.addSubview(bestResultPairsLabel)
        statisticsView.addSubview(bestResultFlipsLabel)
        statisticsView.addSubview(bestResultScoreLabel)
        
        statisticsView.addSubview(bestResultTimeView)
        statisticsView.addSubview(bestResultPairsView)
        statisticsView.addSubview(bestResultFlipsView)
        statisticsView.addSubview(bestResultScoreView)
        
        statisticsView.addSubview(bestResultTimeViewLabel)
        statisticsView.addSubview(bestResultPairsViewLabel)
        statisticsView.addSubview(bestResultFlipsViewLabel)
        statisticsView.addSubview(bestResultScoreViewLabel)
        
        
        //pop-up:
//        gameView.addSubview(gameOverLabel)
        gameView.addSubview(nextLevelLabel)
        
        gameView.addSubview(restartButton)
        gameView.addSubview(menuButton)
        
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
            
            //MARK: - Settings:
            
            settingsView.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 0),
            settingsView.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: 0),
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            settingsView.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
            
            hub.leadingAnchor.constraint(equalTo: gameView.leadingAnchor),
            hub.trailingAnchor.constraint(equalTo: gameView.trailingAnchor),
            hub.topAnchor.constraint(equalTo: gameView.safeAreaLayoutGuide.topAnchor, constant: 0),
            hub.widthAnchor.constraint(equalTo: gameView.widthAnchor),
            
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
            
            titleLabel.bottomAnchor.constraint(equalTo: gameView.bottomAnchor, constant: -45),
            titleLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
            titleTipLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -20),
            titleTipLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor),
            titleTipLabel.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),
            titleTipLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            
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
            rateButton.widthAnchor.constraint(equalToConstant: 120),
            rateButton.heightAnchor.constraint(equalToConstant: 44),
            
            quitButton.topAnchor.constraint(equalTo: muteVibrationButton.bottomAnchor, constant: 92),
            quitButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -52),
            quitButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -117),
            quitButton.widthAnchor.constraint(equalToConstant: 120),
            quitButton.heightAnchor.constraint(equalToConstant: 44),
            
            //Views:
            buttonsView.topAnchor.constraint(equalTo: hub.bottomAnchor, constant: 10),
            buttonsView.leadingAnchor.constraint(equalTo: gameView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonsView.trailingAnchor.constraint(equalTo: gameView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            buttonsView.bottomAnchor.constraint(equalTo: gameView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            //MARK: - GameOverView:
            
            gameOverView.topAnchor.constraint(equalTo: gameView.topAnchor),
            gameOverView.leadingAnchor.constraint(equalTo: gameView.leadingAnchor),
            gameOverView.trailingAnchor.constraint(equalTo: gameView.trailingAnchor),
            gameOverView.bottomAnchor.constraint(equalTo: gameView.bottomAnchor),
            
            gameOverLabel.topAnchor.constraint(equalTo: gameOverView.topAnchor, constant: 99),
            gameOverLabel.centerXAnchor.constraint(equalTo: gameOverView.centerXAnchor),
            
            statisticsView.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 20),
            statisticsView.bottomAnchor.constraint(greaterThanOrEqualTo: menuButton.topAnchor, constant: -50),
            statisticsView.leadingAnchor.constraint(equalTo: gameOverView.leadingAnchor, constant: 20),
            statisticsView.trailingAnchor.constraint(equalTo: gameOverView.trailingAnchor, constant: -20),

            menuButton.bottomAnchor.constraint(equalTo: gameOverView.bottomAnchor, constant: -150),
            menuButton.centerXAnchor.constraint(equalTo: gameOverView.centerXAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 210),
            menuButton.heightAnchor.constraint(equalToConstant: 60),

            separatorLine.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),
            separatorLine.centerYAnchor.constraint(equalTo: statisticsView.centerYAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 5),
            
            verticalCentralSeparatorLine.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            verticalCentralSeparatorLine.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            verticalCentralSeparatorLine.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor),
            verticalCentralSeparatorLine.widthAnchor.constraint(equalToConstant: 5),
            
            verticalLeftPart.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            verticalLeftPart.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            verticalLeftPart.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            verticalLeftPart.trailingAnchor.constraint(equalTo: verticalCentralSeparatorLine.leadingAnchor),
            
            verticalRightPart.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            verticalRightPart.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            verticalRightPart.leadingAnchor.constraint(equalTo: verticalCentralSeparatorLine.trailingAnchor),
            verticalRightPart.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),
            
            verticalLeftSeparatorLine.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            verticalLeftSeparatorLine.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            verticalLeftSeparatorLine.centerXAnchor.constraint(equalTo: verticalLeftPart.centerXAnchor),
            verticalLeftSeparatorLine.widthAnchor.constraint(equalToConstant: 5),
            
            verticalRightSeparatorLine.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            verticalRightSeparatorLine.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            verticalRightSeparatorLine.centerXAnchor.constraint(equalTo: verticalRightPart.centerXAnchor),
            verticalRightSeparatorLine.widthAnchor.constraint(equalToConstant: 5),
            
            horizontalUpPart.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            horizontalUpPart.bottomAnchor.constraint(equalTo: separatorLine.topAnchor),
            horizontalUpPart.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            horizontalUpPart.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),

            horizontalDownPart.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            horizontalDownPart.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            horizontalDownPart.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            horizontalDownPart.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),
            
            horizontalUpSeparatorLine.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            horizontalUpSeparatorLine.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),
            horizontalUpSeparatorLine.centerYAnchor.constraint(equalTo: horizontalUpPart.centerYAnchor),
            horizontalUpSeparatorLine.heightAnchor.constraint(equalToConstant: 5),

            horizontalDownSeparatorLine.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            horizontalDownSeparatorLine.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor),
            horizontalDownSeparatorLine.centerYAnchor.constraint(equalTo: horizontalDownPart.centerYAnchor),
            horizontalDownSeparatorLine.heightAnchor.constraint(equalToConstant: 5),

            //MARK: - YourResults:
            
            yourResultLabel.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            yourResultLabel.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor, constant: 5),
            
            yourResultTimeView.topAnchor.constraint(equalTo: horizontalUpSeparatorLine.bottomAnchor, constant: 5),
            yourResultTimeView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -10),
            yourResultTimeView.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor, constant: 10),
            yourResultTimeView.trailingAnchor.constraint(equalTo: verticalLeftSeparatorLine.leadingAnchor, constant: -5),
            
            yourResultPairsView.topAnchor.constraint(equalTo: horizontalUpSeparatorLine.bottomAnchor, constant: 5),
            yourResultPairsView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -10),
            yourResultPairsView.leadingAnchor.constraint(equalTo: verticalLeftSeparatorLine.trailingAnchor, constant: 5),
            yourResultPairsView.trailingAnchor.constraint(equalTo: verticalCentralSeparatorLine.leadingAnchor, constant: -5),
            
            yourResultFlipsView.topAnchor.constraint(equalTo: horizontalUpSeparatorLine.bottomAnchor, constant: 5),
            yourResultFlipsView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -10),
            yourResultFlipsView.leadingAnchor.constraint(equalTo: verticalCentralSeparatorLine.trailingAnchor, constant: 5),
            yourResultFlipsView.trailingAnchor.constraint(equalTo: verticalRightSeparatorLine.leadingAnchor, constant: -5),

            yourResultScoreView.topAnchor.constraint(equalTo: horizontalUpSeparatorLine.bottomAnchor, constant: 5),
            yourResultScoreView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -10),
            yourResultScoreView.leadingAnchor.constraint(equalTo: verticalRightSeparatorLine.trailingAnchor, constant: 5),
            yourResultScoreView.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor, constant: -10),
            
            yourResultTimeLabel.centerXAnchor.constraint(equalTo: yourResultTimeView.centerXAnchor),
            yourResultTimeLabel.bottomAnchor.constraint(equalTo: horizontalUpSeparatorLine.topAnchor),

            yourResultPairsLabel.centerXAnchor.constraint(equalTo: yourResultPairsView.centerXAnchor),
            yourResultPairsLabel.bottomAnchor.constraint(equalTo: horizontalUpSeparatorLine.topAnchor),

            yourResultFlipsLabel.centerXAnchor.constraint(equalTo: yourResultFlipsView.centerXAnchor),
            yourResultFlipsLabel.bottomAnchor.constraint(equalTo: horizontalUpSeparatorLine.topAnchor),

            yourResultScoreLabel.centerXAnchor.constraint(equalTo: yourResultScoreView.centerXAnchor),
            yourResultScoreLabel.bottomAnchor.constraint(equalTo: horizontalUpSeparatorLine.topAnchor),

            yourResultTimeViewLabel.centerXAnchor.constraint(equalTo: yourResultTimeView.centerXAnchor),
            yourResultTimeViewLabel.centerYAnchor.constraint(equalTo: yourResultTimeView.centerYAnchor),

            yourResultPairsViewLabel.centerXAnchor.constraint(equalTo: yourResultPairsView.centerXAnchor),
            yourResultPairsViewLabel.centerYAnchor.constraint(equalTo: yourResultPairsView.centerYAnchor),

            yourResultFlipsViewLabel.centerXAnchor.constraint(equalTo: yourResultFlipsView.centerXAnchor),
            yourResultFlipsViewLabel.centerYAnchor.constraint(equalTo: yourResultFlipsView.centerYAnchor),

            yourResultScoreViewLabel.centerXAnchor.constraint(equalTo: yourResultScoreView.centerXAnchor),
            yourResultScoreViewLabel.centerYAnchor.constraint(equalTo: yourResultScoreView.centerYAnchor),

            //MARK: - Best results:
            
            bestResultLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            bestResultLabel.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor, constant: 5),

            bestResultTimeView.topAnchor.constraint(equalTo: horizontalDownSeparatorLine.bottomAnchor, constant: 5),
            bestResultTimeView.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: -10),
            bestResultTimeView.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor, constant: 10),
            bestResultTimeView.trailingAnchor.constraint(equalTo: verticalLeftSeparatorLine.leadingAnchor, constant: -5),

            bestResultPairsView.topAnchor.constraint(equalTo: horizontalDownSeparatorLine.bottomAnchor, constant: 5),
            bestResultPairsView.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: -10),
            bestResultPairsView.leadingAnchor.constraint(equalTo: verticalLeftSeparatorLine.trailingAnchor, constant: 5),
            bestResultPairsView.trailingAnchor.constraint(equalTo: verticalCentralSeparatorLine.leadingAnchor, constant: -5),

            bestResultFlipsView.topAnchor.constraint(equalTo: horizontalDownSeparatorLine.bottomAnchor, constant: 5),
            bestResultFlipsView.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: -10),
            bestResultFlipsView.leadingAnchor.constraint(equalTo: verticalCentralSeparatorLine.trailingAnchor, constant: 5),
            bestResultFlipsView.trailingAnchor.constraint(equalTo: verticalRightSeparatorLine.leadingAnchor, constant: -5),

            bestResultScoreView.topAnchor.constraint(equalTo: horizontalDownSeparatorLine.bottomAnchor, constant: 5),
            bestResultScoreView.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: -10),
            bestResultScoreView.leadingAnchor.constraint(equalTo: verticalRightSeparatorLine.trailingAnchor, constant: 5),
            bestResultScoreView.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor, constant: -10),

            bestResultTimeLabel.centerXAnchor.constraint(equalTo: bestResultTimeView.centerXAnchor),
            bestResultTimeLabel.bottomAnchor.constraint(equalTo: horizontalDownSeparatorLine.topAnchor),

            bestResultPairsLabel.centerXAnchor.constraint(equalTo: bestResultPairsView.centerXAnchor),
            bestResultPairsLabel.bottomAnchor.constraint(equalTo: horizontalDownSeparatorLine.topAnchor),

            bestResultFlipsLabel.centerXAnchor.constraint(equalTo: bestResultFlipsView.centerXAnchor),
            bestResultFlipsLabel.bottomAnchor.constraint(equalTo: horizontalDownSeparatorLine.topAnchor),

            bestResultScoreLabel.centerXAnchor.constraint(equalTo: bestResultScoreView.centerXAnchor),
            bestResultScoreLabel.bottomAnchor.constraint(equalTo: horizontalDownSeparatorLine.topAnchor),
            
            bestResultTimeViewLabel.centerXAnchor.constraint(equalTo: bestResultTimeView.centerXAnchor),
            bestResultTimeViewLabel.centerYAnchor.constraint(equalTo: bestResultTimeView.centerYAnchor),

            bestResultPairsViewLabel.centerXAnchor.constraint(equalTo: bestResultPairsView.centerXAnchor),
            bestResultPairsViewLabel.centerYAnchor.constraint(equalTo: bestResultPairsView.centerYAnchor),

            bestResultFlipsViewLabel.centerXAnchor.constraint(equalTo: bestResultFlipsView.centerXAnchor),
            bestResultFlipsViewLabel.centerYAnchor.constraint(equalTo: bestResultFlipsView.centerYAnchor),

            bestResultScoreViewLabel.centerXAnchor.constraint(equalTo: bestResultScoreView.centerXAnchor),
            bestResultScoreViewLabel.centerYAnchor.constraint(equalTo: bestResultScoreView.centerYAnchor),

            
            //MARK: - HUD:
            
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
            nextLevelLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            nextLevelLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),

            restartButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: gameView.centerYAnchor, constant: 100),
            restartButton.widthAnchor.constraint(equalToConstant: 120),
            
            //Animations:
            plusCoinsAnimationsLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            plusCoinsAnimationsLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor),
        ])
    }    
    
    //MARK: - setup Settings Appearence:
    
    func setupSettingsButtons(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1.0
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupSettingsLabels(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
    }
    
    //MARK: - setup Statistics Appearence:
    
    func setupStatisticsLabels(_ label: UILabel) {
        label.alpha = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 18)
    }
    
    func setupStatisticsViews(_ view: UIView) {
        view.alpha = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 1.0
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupStatisticsLabelsInsideViews(_ label: UILabel) {
        label.alpha = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 50)
    }
    
}
