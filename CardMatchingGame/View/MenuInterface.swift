//
//  MenuInterface.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/6.
//

import UIKit

class MenuInterface: UIView {
    
    let palette = Palette()
    let gameInterface = GameInterface()
    
    //MARK: - Views:
    
    var menuView: UIView = {
        let menuView = UIView()
        return menuView
    }()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: FigmaKey.backgroundMenu.rawValue)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var coverImageView: UIImageView = {
        let coverImageView = UIImageView(frame: .zero)
        coverImageView.isHidden = true
        coverImageView.alpha = 1
        coverImageView.image = UIImage(named: FigmaKey.backgroundSettings.rawValue)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        return coverImageView
    }()
    
    lazy var hub: UIView = {
        let hub = UIView()
        hub.backgroundColor = UIColor(red: 1.00, green: 0.37, blue: 0.25, alpha: 0.5)
        hub.translatesAutoresizingMaskIntoConstraints = false
        hub.layer.borderWidth = 0
        hub.alpha = 0
        return hub
    }()
    
    //MARK: - Labels:
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.alpha = 0.5
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "MATCH PAIR"
        titleLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 96)
        return titleLabel
    }()
    
    lazy var classicModeDescriptionLabel: UILabel = {
        let classicModeDescriptionLabel = UILabel()
        classicModeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        classicModeDescriptionLabel.textColor = .white
        classicModeDescriptionLabel.alpha = 0.5
        classicModeDescriptionLabel.textAlignment = .left
        classicModeDescriptionLabel.adjustsFontSizeToFitWidth = true
        classicModeDescriptionLabel.text = "classic mode >"
        classicModeDescriptionLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return classicModeDescriptionLabel
    }()
    
    lazy var difficultyDescriptionLabel: UILabel = {
        let difficultyDescriptionLabel = UILabel()
        difficultyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyDescriptionLabel.textColor = .white
        difficultyDescriptionLabel.alpha = 0.5
        difficultyDescriptionLabel.textAlignment = .left
        difficultyDescriptionLabel.adjustsFontSizeToFitWidth = true
        difficultyDescriptionLabel.text = "< difficulty"
        difficultyDescriptionLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return difficultyDescriptionLabel
    }()
    
    lazy var timeModeDescriptionLabel: UILabel = {
        let timeModeDescriptionLabel = UILabel()
        timeModeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        timeModeDescriptionLabel.textColor = .white
        timeModeDescriptionLabel.alpha = 0.5
        timeModeDescriptionLabel.textAlignment = .left
        timeModeDescriptionLabel.adjustsFontSizeToFitWidth = true
        timeModeDescriptionLabel.text = "< time"
        timeModeDescriptionLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return timeModeDescriptionLabel
    }()
    
    lazy var hardcoreDescriptionLabel: UILabel = {
        let hardcoreDescriptionLabel = UILabel()
        hardcoreDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        hardcoreDescriptionLabel.textColor = .white
        hardcoreDescriptionLabel.alpha = 0.5
        hardcoreDescriptionLabel.textAlignment = .left
        hardcoreDescriptionLabel.adjustsFontSizeToFitWidth = true
        hardcoreDescriptionLabel.text = "hard mode >"
        hardcoreDescriptionLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return hardcoreDescriptionLabel
    }()
    
    lazy var collectionDescriptionLabel: UILabel = {
        let collectionDescriptionLabel = UILabel()
        collectionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionDescriptionLabel.textColor = .white
        collectionDescriptionLabel.alpha = 0.5
        collectionDescriptionLabel.textAlignment = .left
        collectionDescriptionLabel.adjustsFontSizeToFitWidth = true
        collectionDescriptionLabel.text = "card sets >"
        collectionDescriptionLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return collectionDescriptionLabel
    }()
    
    var coins: Int = Properties.coins {
        didSet {
            coinLabel.text = "🪙 \(coins)"
        }
    }
    
    lazy var coinLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.textColor = UIColor.black
        coinLabel.textAlignment = .left
        coinLabel.text = "🪙 \(coins)"
        coinLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return coinLabel
    }()

    //MARK: - Buttons:

    lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.setImage(UIImage(systemName: "hand.tap")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.titleLabel?.textAlignment = .center
        playButton.centerTextAndImage(spacing: 5)
        setupAppearence(playButton)
        playButton.backgroundColor = UIColor(red: 0.20, green: 0.89, blue: 0.27, alpha: 1.00)
        return playButton
    }()
    
    lazy var difficultyButton: UIButton = {
        let difficultyButton = UIButton()
        difficultyButton.setTitle("Easy", for: .normal)
        difficultyButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysOriginal), for: .normal)
        difficultyButton.titleLabel?.textAlignment = .center
        difficultyButton.centerTextAndImage(spacing: 5)
        setupAppearence(difficultyButton)
        difficultyButton.backgroundColor = .green
        return difficultyButton
    }()
    
    lazy var timeModeButton: UIButton = {
        let timeModeButton = UIButton()
        timeModeButton.setTitle("3 min.", for: .normal)
        timeModeButton.setImage(UIImage(systemName: "clock.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        timeModeButton.titleLabel?.textAlignment = .center
        timeModeButton.centerTextAndImage(spacing: 5)
        setupAppearence(timeModeButton)
        timeModeButton.backgroundColor = .yellow
        return timeModeButton
    }()
    
    lazy var hardcoreModeButton: UIButton = {
        let hardcoreModeButton = UIButton()
        hardcoreModeButton.setTitle("Hardcore", for: .normal)
        hardcoreModeButton.setImage(UIImage(systemName: "flame")?.withRenderingMode(.alwaysOriginal), for: .normal)
        setupAppearence(hardcoreModeButton)
        hardcoreModeButton.titleLabel?.textAlignment = .center
        hardcoreModeButton.centerTextAndImage(spacing: 5)
        hardcoreModeButton.backgroundColor = UIColor(red: 0.86, green: 0.44, blue: 0.44, alpha: 1.00)
        return hardcoreModeButton
    }()
    
    lazy var collectionButton: UIButton = {
        let collectionButton = UIButton()
        collectionButton.setTitle("Collection", for: .normal)
        collectionButton.setImage(UIImage(systemName: "crown")?.withRenderingMode(.alwaysOriginal), for: .normal)
        setupAppearence(collectionButton)
        collectionButton.titleLabel?.textAlignment = .center
        collectionButton.centerTextAndImage(spacing: 5)
        collectionButton.backgroundColor = UIColor(red: 0.07, green: 0.75, blue: 0.89, alpha: 1.00)
        return collectionButton
    }()

    lazy var resetButton: UIButton = {
       let resetButton = UIButton()
        resetButton.setTitle("  reset  ", for: .normal)
        setupAppearence(resetButton)
        resetButton.backgroundColor = .red
        return resetButton
    }()
    
    lazy var addCoinButton: UIButton = {
       let addCoinButton = UIButton()
        addCoinButton.setTitle("  🪙 Add Coin  ", for: .normal)
        setupAppearence(addCoinButton)
        addCoinButton.backgroundColor = .green
        return addCoinButton
    }()
    
    //MARK: - Settings:
    
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
    
    lazy var settingsView: UIView = {
        let settingsView = UIView()
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.isHidden = true
        settingsView.alpha = 1
        settingsView.layer.borderWidth = 0
        settingsView.layer.cornerRadius = 0
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
       let label = UILabel()
        label.text = "Music"
//        label.addSystemImage(imageName: "pianokeys")
        setupSettingsLabels(label)
        return label
    }()
    
    lazy var settingsSound: UILabel = {
       let label = UILabel()
        label.text = "Sound"
//        label.addSystemImage(imageName: "speaker.wave.3")
        setupSettingsLabels(label)
        return label
    }()
    
    lazy var settingsVibration: UILabel = {
       let label = UILabel()
        label.text = "Vibration"
        setupSettingsLabels(label)
        return label
    }()
    
    //MARK: - Settings - Buttons:

    lazy var muteMusicButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle("mute", for: .normal)
        button.backgroundColor = Properties.defaultMusicButtonColor
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
    }()
    
    lazy var muteSoundButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle("mute", for: .normal)
        button.backgroundColor = Properties.defaultSoundButtonColor
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
    }()
    
    lazy var muteVibrationButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle("mute", for: .normal)
        button.backgroundColor = Properties.defaultSoundButtonColor
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        return button
    }()
    
    lazy var quitButton: UIButton = {
        let quitButton = UIButton()
        quitButton.setTitle("quit", for: .normal)
        setupSettingsButtons(quitButton)
        return quitButton
    }()
    
    lazy var rateButton: UIButton = {
        let rateButton = UIButton()
        rateButton.setTitle("rate us", for: .normal)
        setupSettingsButtons(rateButton)
        rateButton.alpha = 0.3
        rateButton.backgroundColor = .systemGreen
        return rateButton
    }()
    
    //MARK: - setupSubviews:
    
    func setupSubviews() {
        menuView.addSubview(coverImageView)
        menuView.addSubview(hub)
        
        menuView.addSubview(titleLabel)
        menuView.addSubview(coinLabel)
        menuView.addSubview(classicModeDescriptionLabel)
        menuView.addSubview(difficultyDescriptionLabel)
        menuView.addSubview(timeModeDescriptionLabel)
        menuView.addSubview(hardcoreDescriptionLabel)
        menuView.addSubview(collectionDescriptionLabel)
        
        menuView.addSubview(playButton)
        menuView.addSubview(timeModeButton)
        menuView.addSubview(hardcoreModeButton)
        menuView.addSubview(collectionButton)
        menuView.addSubview(difficultyButton)
        menuView.addSubview(resetButton)
        menuView.addSubview(addCoinButton)
        
        //Settings:
        menuView.addSubview(settingsButton)
        menuView.addSubview(settingsView)
        
        settingsView.addSubview(settingsMusic)
        settingsView.addSubview(settingsSound)
        settingsView.addSubview(settingsVibration)
        
        settingsView.addSubview(muteMusicButton)
        settingsView.addSubview(muteSoundButton)
        settingsView.addSubview(muteVibrationButton)
        
//        settingsView.addSubview(quitButton)
        settingsView.addSubview(rateButton)
        settingsView.addSubview(settingsBackground)
        settingsView.sendSubviewToBack(settingsBackground)
        
        menuView.bringSubviewToFront(coverImageView)
        menuView.bringSubviewToFront(settingsButton)
        menuView.bringSubviewToFront(settingsView)
        menuView.bringSubviewToFront(coinLabel)
        
    }
    
    //MARK: - setupConstraints:
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: menuView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: menuView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
            
            hub.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            hub.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            hub.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 52),
            hub.widthAnchor.constraint(equalTo: menuView.widthAnchor),
//            hub.heightAnchor.constraint(equalToConstant: 53),
    
            coinLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            coinLabel.leadingAnchor.constraint(equalTo: hub.leadingAnchor, constant: 11),

            settingsButton.topAnchor.constraint(equalTo: hub.topAnchor, constant: 6),
            settingsButton.bottomAnchor.constraint(equalTo: hub.bottomAnchor, constant: -6),
            settingsButton.trailingAnchor.constraint(equalTo: hub.trailingAnchor, constant: -14),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            
            //MARK: - Labels:
            
            titleLabel.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -45),
            titleLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            
            classicModeDescriptionLabel.topAnchor.constraint(equalTo: playButton.topAnchor),
            classicModeDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
            classicModeDescriptionLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
            classicModeDescriptionLabel.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            
            difficultyDescriptionLabel.topAnchor.constraint(equalTo: difficultyButton.topAnchor),
            difficultyDescriptionLabel.leadingAnchor.constraint(equalTo: difficultyButton.trailingAnchor, constant: 10),
            difficultyDescriptionLabel.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            difficultyDescriptionLabel.bottomAnchor.constraint(equalTo: difficultyButton.bottomAnchor),
            
            timeModeDescriptionLabel.topAnchor.constraint(equalTo: timeModeButton.topAnchor),
            timeModeDescriptionLabel.leadingAnchor.constraint(equalTo: timeModeButton.trailingAnchor, constant: 10),
            timeModeDescriptionLabel.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            timeModeDescriptionLabel.bottomAnchor.constraint(equalTo: timeModeButton.bottomAnchor),
            
            hardcoreDescriptionLabel.topAnchor.constraint(equalTo: hardcoreModeButton.topAnchor),
            hardcoreDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
            hardcoreDescriptionLabel.trailingAnchor.constraint(equalTo: hardcoreModeButton.leadingAnchor, constant: -10),
            hardcoreDescriptionLabel.bottomAnchor.constraint(equalTo: hardcoreModeButton.bottomAnchor),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: collectionButton.topAnchor),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: collectionButton.leadingAnchor, constant: -10),
            collectionDescriptionLabel.bottomAnchor.constraint(equalTo: collectionButton.bottomAnchor),
            
            //MARK: - Buttons:

            playButton.topAnchor.constraint(greaterThanOrEqualTo: hub.bottomAnchor, constant: 100),
            playButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 57), // 50
            playButton.widthAnchor.constraint(equalToConstant: 137), // 120
            
            difficultyButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 15),
            difficultyButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            difficultyButton.heightAnchor.constraint(equalToConstant: 57),
            difficultyButton.widthAnchor.constraint(equalToConstant: 137),
            
            timeModeButton.topAnchor.constraint(equalTo: difficultyButton.bottomAnchor, constant: 15),
            timeModeButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            timeModeButton.heightAnchor.constraint(equalToConstant: 57),
            timeModeButton.widthAnchor.constraint(equalToConstant: 137),
            
            hardcoreModeButton.topAnchor.constraint(equalTo: timeModeButton.bottomAnchor, constant: 40),
            hardcoreModeButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            hardcoreModeButton.heightAnchor.constraint(equalToConstant: 57),
            hardcoreModeButton.widthAnchor.constraint(equalToConstant: 137),
            
            collectionButton.topAnchor.constraint(equalTo: hardcoreModeButton.bottomAnchor, constant: 40),
            collectionButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            collectionButton.heightAnchor.constraint(equalToConstant: 57),
            collectionButton.widthAnchor.constraint(equalToConstant: 137),

            resetButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 30),
            resetButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            
            addCoinButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            addCoinButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            addCoinButton.heightAnchor.constraint(equalToConstant: 30),
            addCoinButton.widthAnchor.constraint(equalToConstant: 80),
            addCoinButton.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.topAnchor, constant: -50),
            
            //MARK: - Settings:
            
            settingsView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            settingsView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            
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
        ])
    }
    
    //MARK: - setGradientBackground
    
    func setGradientBackground() {
        let palette = Palette()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = menuView.bounds
        gradientLayer.colors = [
            palette.wildCarribeanGrean.cgColor,
            palette.darkMountainMeadow.cgColor,
            palette.fuelTown.cgColor,
        ]
        menuView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - setup Appearence:
    
    func setupAppearence(_ thisButton: UIButton) {
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisButton.tag = 1
        thisButton.setTitleColor(UIColor.black, for: .normal)
        thisButton.layer.borderWidth = 0
        thisButton.layer.cornerRadius = 10
        thisButton.layer.shadowColor = UIColor.black.cgColor
        thisButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        thisButton.layer.shadowRadius = 5
        thisButton.layer.shadowOpacity = 0.5
        thisButton.isUserInteractionEnabled = true
//        thisButton.titleLabel?.font = UIFont(name: FontKey.AmericanTypewriterBold.rawValue, size: 20)
        thisButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        thisButton.backgroundColor = palette.wildCarribeanGrean
        thisButton.layer.shouldRasterize = true
        thisButton.layer.rasterizationScale = UIScreen.main.scale
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
        thisButton.tintColor = .red
    }
    
    func setupSettingsLabels(_ thisLabel: UILabel) {
        thisLabel.translatesAutoresizingMaskIntoConstraints = false
        thisLabel.textAlignment = .left
//        thisLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 25)
        thisLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
    }
}
