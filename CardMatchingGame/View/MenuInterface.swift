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
        backgroundImageView.alpha = 0.3
        backgroundImageView.image = UIImage(named: ImageKey.envelope1.rawValue)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var coverImageView: UIImageView = {
        let coverImageView = UIImageView(frame: .zero)
        coverImageView.isHidden = true
        coverImageView.alpha = 1
        coverImageView.image = UIImage(named: ImageKey.envelope4Large.rawValue)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        return coverImageView
    }()
    
    //MARK: - Labels:
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "MATCH PAIR GAME (v.0.5)"
        titleLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedLight.rawValue, size: 25)
        return titleLabel
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
        coinLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 25)
        return coinLabel
    }()

    //MARK: - Buttons:
    
    lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Classic", for: .normal)
        setupAppearence(playButton)
        return playButton
    }()
    
    lazy var timeModeButton: UIButton = {
        let timeModeButton = UIButton()
        timeModeButton.setTitle("Time", for: .normal)
        setupAppearence(timeModeButton)
        timeModeButton.alpha = 0.3
        return timeModeButton
    }()
    
    lazy var hardcoreModeButton: UIButton = {
        let hardcoreModeButton = UIButton()
        hardcoreModeButton.setTitle("Hardcore", for: .normal)
        setupAppearence(hardcoreModeButton)
        hardcoreModeButton.alpha = 1
        return hardcoreModeButton
    }()
    
    lazy var collectionButton: UIButton = {
        let collectionButton = UIButton()
        collectionButton.setTitle("Collection", for: .normal)
        setupAppearence(collectionButton)
        collectionButton.backgroundColor = palette.cyanite
        return collectionButton
    }()
    
    lazy var difficultyButton: UIButton = {
        let difficultyButton = UIButton()
        difficultyButton.setTitle("Easy", for: .normal)
        setupAppearence(difficultyButton)
        difficultyButton.alpha = 1
        difficultyButton.backgroundColor = .green
        return difficultyButton
    }()
    
    lazy var resetButton: UIButton = {
       let resetButton = UIButton()
        resetButton.setTitle(" ⚠️ RESET ", for: .normal)
        setupAppearence(resetButton)
        resetButton.backgroundColor = .red
        return resetButton
    }()
    
    lazy var addCoinButton: UIButton = {
       let addCoinButton = UIButton()
        addCoinButton.setTitle(" 🪙 Add Coin ", for: .normal)
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
    
    //MARK: - Settings - Buttons:

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
    
    lazy var quitButton: UIButton = {
        let quitButton = UIButton()
        quitButton.setTitle(" Quit ", for: .normal)
        setupSettingsButtons(quitButton)
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
    
    //MARK: - setupSubviews:
    
    func setupSubviews() {
        menuView.addSubview(coverImageView)
        
        menuView.addSubview(titleLabel)
        menuView.addSubview(coinLabel)
        
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
            
            coinLabel.topAnchor.constraint(equalTo: menuView.layoutMarginsGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.leadingAnchor, constant: 5),
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: menuView.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            playButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            timeModeButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            timeModeButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            timeModeButton.heightAnchor.constraint(equalToConstant: 50),
            timeModeButton.widthAnchor.constraint(equalToConstant: 120),
            
            hardcoreModeButton.topAnchor.constraint(equalTo: timeModeButton.bottomAnchor, constant: 10),
            hardcoreModeButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            hardcoreModeButton.heightAnchor.constraint(equalToConstant: 50),
            hardcoreModeButton.widthAnchor.constraint(equalToConstant: 120),
            
            difficultyButton.topAnchor.constraint(equalTo: hardcoreModeButton.bottomAnchor, constant: 10),
            difficultyButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            difficultyButton.heightAnchor.constraint(equalToConstant: 50),
            difficultyButton.widthAnchor.constraint(equalToConstant: 120),
            
            collectionButton.topAnchor.constraint(equalTo: difficultyButton.bottomAnchor, constant: 50),
            collectionButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            collectionButton.heightAnchor.constraint(equalToConstant: 50),
            collectionButton.widthAnchor.constraint(equalToConstant: 120),

            resetButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 50),
            resetButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 120),
            
            addCoinButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            addCoinButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            addCoinButton.heightAnchor.constraint(equalToConstant: 50),
            addCoinButton.widthAnchor.constraint(equalToConstant: 120),
            addCoinButton.bottomAnchor.constraint(greaterThanOrEqualTo: menuView.bottomAnchor, constant: -170),
            
            settingsButton.topAnchor.constraint(equalTo: menuView.layoutMarginsGuide.topAnchor, constant: -10),
            settingsButton.trailingAnchor.constraint(equalTo: menuView.layoutMarginsGuide.trailingAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            //settings:
            settingsView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 30),
            settingsView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -30),
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            settingsView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            
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
            
//            quitButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
//            quitButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20),
//            quitButton.widthAnchor.constraint(equalToConstant: 100),
            
//            rateButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            rateButton.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            rateButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20),
            rateButton.widthAnchor.constraint(equalToConstant: 100),
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
        thisButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        thisButton.layer.shadowRadius = 6
        thisButton.layer.shadowOpacity = 1.0
        thisButton.isUserInteractionEnabled = true
        thisButton.titleLabel?.font = UIFont(name: FontKey.AmericanTypewriterBold.rawValue, size: 20)
        thisButton.backgroundColor = palette.wildCarribeanGrean
        thisButton.layer.shouldRasterize = true
        thisButton.layer.rasterizationScale = UIScreen.main.scale
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
        thisLabel.font = UIFont(name: FontKey.AmericanTypewriterCondensedBold.rawValue, size: 25)
    }
}
