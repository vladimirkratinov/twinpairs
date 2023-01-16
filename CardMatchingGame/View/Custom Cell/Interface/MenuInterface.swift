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
        let imageView = UIImageView(frame: .zero)
        imageView.alpha = 1
        imageView.image = UIImage(named: FigmaKey.backgroundGame.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var coverImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.isHidden = true
        imageView.alpha = 1
        imageView.image = UIImage(named: FigmaKey.backgroundSettings.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var hub: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.00, green: 0.37, blue: 0.25, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0
        view.alpha = 0
        return view
    }()
    
    //MARK: - Labels:
    
    lazy var largeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0.2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "twin pairs"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 96)
        return label
    }()
    
    lazy var classicModeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "classic mode >"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return label
    }()
    
    lazy var difficultyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
//        difficultyDescriptionLabel.text = "< difficulty"
        label.text = "difficulty >"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return label
    }()
    
    lazy var timeModeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
//        timeModeDescriptionLabel.text = "< time"
        label.text = "time >"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return label
    }()
    
    lazy var hardcoreDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0.5
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "hard mode >"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        label.isHidden = true
        return label
    }()
    
    lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "card sets >"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        return label
    }()
    
    var coins: Int = Properties.coins {
        didSet {
            coinLabel.text = "🪙 \(coins)"
        }
    }
    
    lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "🪙 \(coins)"
        label.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return label
    }()

    //MARK: - Buttons:

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
        setupAppearence(button)
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 36)
        button.backgroundColor = palette.UIGreen
        return button
    }()
    
    lazy var difficultyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Easy", for: .normal)
        button.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
        setupAppearence(button)
        button.backgroundColor = .green
        return button
    }()
    
    lazy var timeModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("3 min.", for: .normal)
        button.setImage(UIImage(systemName: "timer")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
        setupAppearence(button)
        button.backgroundColor = .green
        return button
    }()
    
    lazy var hardcoreModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("hardcore", for: .normal)
        button.setImage(UIImage(systemName: "flame")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setupAppearence(button)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
        button.backgroundColor = UIColor(red: 0.86, green: 0.44, blue: 0.44, alpha: 1.00)
        button.isHidden = true
        return button
    }()
    
    lazy var collectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("collection", for: .normal)
        button.setImage(UIImage(systemName: "crown")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setupAppearence(button)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
        button.backgroundColor = UIColor(red: 0.07, green: 0.75, blue: 0.89, alpha: 1.00) //blue
        return button
    }()
    
    lazy var shopButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("shop", for: .normal)
        button.setImage(UIImage(systemName: "tag")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setupAppearence(button)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
//        button.backgroundColor = UIColor(red: 1.00, green: 0.42, blue: 0.42, alpha: 1.00) //pink
        button.backgroundColor = UIColor(red: 0.07, green: 0.75, blue: 0.89, alpha: 1.00) //blue
        return button
    }()
    
    lazy var tutorialButton: UIButton = {
        let button = UIButton()
        button.setTitle("tutorial", for: .normal)
        button.setImage(UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setupAppearence(button)
        button.titleLabel?.textAlignment = .center
        button.centerTextAndImage(spacing: 5)
//        button.backgroundColor = UIColor(red: 1.00, green: 0.42, blue: 0.42, alpha: 1.00) //pink
        button.backgroundColor = UIColor(red: 0.07, green: 0.75, blue: 0.89, alpha: 1.00) //blue
        return button
    }()

    lazy var resetButton: UIButton = {
       let button = UIButton()
        button.setTitle("Reset", for: .normal)
        setupAppearenceAdminButtons(button)
        return button
    }()
    
    lazy var addCoinButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add Coin", for: .normal)
        setupAppearenceAdminButtons(button)
        return button
    }()
    
    //MARK: - Settings:
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "gears"), for: .normal)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var settingsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.alpha = 1
        view.layer.borderWidth = 0
        view.layer.cornerRadius = 0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var settingsBackground: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.alpha = 1
        imageView.image = UIImage(named: FigmaKey.settings.rawValue)
        imageView.contentMode = .redraw
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Settings - Labels:
    
    lazy var settingsMusic: UILabel = {
       let label = UILabel()
        label.text = "Music"
        setupSettingsLabels(label)
        return label
    }()
    
    lazy var settingsSound: UILabel = {
       let label = UILabel()
        label.text = "Sound"
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
        button.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultMusicButtonColor
        return button
    }()
    
    lazy var muteSoundButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultSoundButtonColor
        return button
    }()
    
    lazy var muteVibrationButton: UIButton = {
        let button = UIButton()
        setupSettingsButtons(button)
        button.setTitle(Properties.defaultVibrationButtonLabel, for: .normal)
        button.backgroundColor = Properties.defaultSoundButtonColor
        return button
    }()
    
    lazy var quitButton: UIButton = {
        let button = UIButton()
        quitButton.setTitle("quit", for: .normal)
        setupSettingsButtons(button)
        return button
    }()
    
    lazy var rateButton: UIButton = {
        let button = UIButton()
        button.setTitle("rate us", for: .normal)
        setupSettingsButtons(button)
        button.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.centerTextAndImage(spacing: 5)
        button.tintColor = .black
        button.alpha = 0.3
        button.isEnabled = false
        button.backgroundColor = .systemGreen
        return button
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setTitle("contact us", for: .normal)
        setupSettingsButtons(button)
        button.setImage(UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.centerTextAndImage(spacing: 1)
        button.tintColor = .black
        button.alpha = 1
        button.backgroundColor = .systemGreen
        return button
    }()
    
    lazy var restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0
        button.setTitle("restore purchases", for: .normal)
        button.setImage(UIImage(systemName: "lock")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .black
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - setupSubviews:
    
    func setupSubviews() {
        menuView.addSubview(coverImageView)
        menuView.addSubview(hub)
        
        menuView.addSubview(largeTitleLabel)
        menuView.addSubview(coinLabel)
//        menuView.addSubview(classicModeDescriptionLabel)
//        menuView.addSubview(difficultyDescriptionLabel)
//        menuView.addSubview(timeModeDescriptionLabel)
//        menuView.addSubview(hardcoreDescriptionLabel)
//        menuView.addSubview(collectionDescriptionLabel)
        
        menuView.addSubview(playButton)
        menuView.addSubview(timeModeButton)
        menuView.addSubview(hardcoreModeButton)
        menuView.addSubview(collectionButton)
        menuView.addSubview(difficultyButton)
        menuView.addSubview(shopButton)
        menuView.addSubview(tutorialButton)
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
        settingsView.addSubview(rateButton)
        settingsView.addSubview(contactButton)
        settingsView.addSubview(restorePurchasesButton)
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
            hub.topAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.topAnchor, constant: 0),
            hub.widthAnchor.constraint(equalTo: menuView.widthAnchor),
    
            coinLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
            coinLabel.leadingAnchor.constraint(equalTo: hub.leadingAnchor, constant: 11),
            
            settingsButton.topAnchor.constraint(equalTo: hub.topAnchor, constant: 6),
            settingsButton.bottomAnchor.constraint(equalTo: hub.bottomAnchor, constant: -6),
            settingsButton.trailingAnchor.constraint(equalTo: hub.trailingAnchor, constant: -14),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            
            //MARK: - Labels:
            
            largeTitleLabel.topAnchor.constraint(equalTo: tutorialButton.bottomAnchor, constant: 10),
            largeTitleLabel.bottomAnchor.constraint(equalTo: menuView.layoutMarginsGuide.bottomAnchor, constant: 10),
            largeTitleLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
            largeTitleLabel.trailingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.trailingAnchor),
            largeTitleLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            
//            classicModeDescriptionLabel.topAnchor.constraint(equalTo: playButton.topAnchor),
//            classicModeDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
//            classicModeDescriptionLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
//            classicModeDescriptionLabel.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
//
//            difficultyDescriptionLabel.topAnchor.constraint(equalTo: difficultyButton.topAnchor),
//            difficultyDescriptionLabel.trailingAnchor.constraint(equalTo: difficultyButton.leadingAnchor, constant: -10),
//            difficultyDescriptionLabel.bottomAnchor.constraint(equalTo: difficultyButton.bottomAnchor),
//
//            timeModeDescriptionLabel.topAnchor.constraint(equalTo: timeModeButton.topAnchor),
//            timeModeDescriptionLabel.trailingAnchor.constraint(equalTo: timeModeButton.leadingAnchor, constant: -10),
//            timeModeDescriptionLabel.bottomAnchor.constraint(equalTo: timeModeButton.bottomAnchor),
//
//            hardcoreDescriptionLabel.topAnchor.constraint(equalTo: hardcoreModeButton.topAnchor),
//            hardcoreDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
//            hardcoreDescriptionLabel.trailingAnchor.constraint(equalTo: hardcoreModeButton.leadingAnchor, constant: -10),
//            hardcoreDescriptionLabel.bottomAnchor.constraint(equalTo: hardcoreModeButton.bottomAnchor),
//
//            collectionDescriptionLabel.topAnchor.constraint(equalTo: collectionButton.topAnchor),
//            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor),
//            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: collectionButton.leadingAnchor, constant: -10),
//            collectionDescriptionLabel.bottomAnchor.constraint(equalTo: collectionButton.bottomAnchor),
            
            //MARK: - Buttons:
            
//            playButton.topAnchor.constraint(equalTo: hub.bottomAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: difficultyButton.topAnchor, constant: -40),
            playButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 80), // 50
            playButton.widthAnchor.constraint(equalToConstant: 160), // 120
            
            difficultyButton.bottomAnchor.constraint(equalTo: timeModeButton.topAnchor, constant: -10),
            difficultyButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            difficultyButton.heightAnchor.constraint(equalToConstant: 57),
            difficultyButton.widthAnchor.constraint(equalToConstant: 137),
            
            timeModeButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            timeModeButton.centerYAnchor.constraint(equalTo: menuView.centerYAnchor, constant: -30),
            timeModeButton.heightAnchor.constraint(equalToConstant: 57),
            timeModeButton.widthAnchor.constraint(equalToConstant: 137),

            collectionButton.topAnchor.constraint(equalTo: timeModeButton.bottomAnchor, constant: 40),
            collectionButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            collectionButton.heightAnchor.constraint(equalToConstant: 57),
            collectionButton.widthAnchor.constraint(equalToConstant: 137),
            
//            shopButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 15),
//            shopButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
//            shopButton.heightAnchor.constraint(equalToConstant: 57),
//            shopButton.widthAnchor.constraint(equalToConstant: 137),
            
            tutorialButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 15),
            tutorialButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            tutorialButton.heightAnchor.constraint(equalToConstant: 57),
            tutorialButton.widthAnchor.constraint(equalToConstant: 137),

            resetButton.topAnchor.constraint(equalTo: tutorialButton.bottomAnchor, constant: 30),
            resetButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            
            addCoinButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            addCoinButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            addCoinButton.heightAnchor.constraint(equalToConstant: 30),
            addCoinButton.widthAnchor.constraint(equalToConstant: 80),
            addCoinButton.bottomAnchor.constraint(greaterThanOrEqualTo: largeTitleLabel.topAnchor, constant: -50),
            
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
            rateButton.widthAnchor.constraint(equalToConstant: 120),
            rateButton.heightAnchor.constraint(equalToConstant: 44),
            
            contactButton.topAnchor.constraint(equalTo: muteVibrationButton.bottomAnchor, constant: 92),
            contactButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -50),
            contactButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -117),
            contactButton.widthAnchor.constraint(equalToConstant: 120),
            contactButton.heightAnchor.constraint(equalToConstant: 44),
            
            restorePurchasesButton.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: 40),
            restorePurchasesButton.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
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
    
    func setupAppearence(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 1
        button.tintColor = .black
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        button.backgroundColor = palette.wildCarribeanGrean
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupAppearenceAdminButtons(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = .black
        button.backgroundColor = .systemPink
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
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
        button.tintColor = .red
    }
    
    func setupSettingsLabels(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
    }
}
