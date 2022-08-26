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
    
    var menuView: UIView = {
        let menuView = UIView()
        return menuView
    }()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.3
        backgroundImageView.image = UIImage(named: ImageKey.LaunchScreen2.rawValue)
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
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "MATCH PAIR GAME (v.0.5)"
        titleLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
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
        coinLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 25)
        return coinLabel
    }()
    
    
    
    lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Classic", for: .normal)
        playButton.tag = 1
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        playButton.layer.borderWidth = 3
        playButton.layer.cornerRadius = 10
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        playButton.layer.shadowRadius = 1
        playButton.layer.shadowOpacity = 1.0
        playButton.isUserInteractionEnabled = true
        playButton.backgroundColor = palette.wildCarribeanGrean
        playButton.layer.shouldRasterize = true
        playButton.layer.rasterizationScale = UIScreen.main.scale
        return playButton
    }()
    
    lazy var timeModeButton: UIButton = {
        let timeModeButton = UIButton()
        timeModeButton.translatesAutoresizingMaskIntoConstraints = false
        timeModeButton.alpha = 0.5
        timeModeButton.tag = 1
        timeModeButton.setTitle("Time", for: .normal)
        timeModeButton.setTitleColor(UIColor.black, for: .normal)
        timeModeButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        timeModeButton.layer.borderWidth = 3
        timeModeButton.layer.cornerRadius = 10
        timeModeButton.layer.shadowColor = UIColor.black.cgColor
        timeModeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        timeModeButton.layer.shadowRadius = 1
        timeModeButton.layer.shadowOpacity = 1.0
        timeModeButton.isUserInteractionEnabled = true
        timeModeButton.isEnabled = false
        timeModeButton.backgroundColor = UIColor.systemOrange
        timeModeButton.layer.shouldRasterize = true
        timeModeButton.layer.rasterizationScale = UIScreen.main.scale
        return timeModeButton
    }()
    
    lazy var hardcoreModeButton: UIButton = {
        let hardcoreModeButton = UIButton()
        hardcoreModeButton.translatesAutoresizingMaskIntoConstraints = false
        hardcoreModeButton.alpha = 0.5
        hardcoreModeButton.tag = 1
        hardcoreModeButton.setTitle("Hardcore", for: .normal)
        hardcoreModeButton.setTitleColor(UIColor.black, for: .normal)
        hardcoreModeButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        hardcoreModeButton.layer.borderWidth = 3
        hardcoreModeButton.layer.cornerRadius = 10
        hardcoreModeButton.layer.shadowColor = UIColor.black.cgColor
        hardcoreModeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        hardcoreModeButton.layer.shadowRadius = 1
        hardcoreModeButton.layer.shadowOpacity = 1.0
        hardcoreModeButton.isUserInteractionEnabled = true
        hardcoreModeButton.isEnabled = false
        hardcoreModeButton.backgroundColor = UIColor.systemRed
        hardcoreModeButton.layer.shouldRasterize = true
        hardcoreModeButton.layer.rasterizationScale = UIScreen.main.scale
        return hardcoreModeButton
    }()
    
    lazy var collectionButton: UIButton = {
        let collectionButton = UIButton()
        collectionButton.translatesAutoresizingMaskIntoConstraints = false
        collectionButton.alpha = 1
        collectionButton.tag = 1
        collectionButton.setTitle("Collection", for: .normal)
        collectionButton.setTitleColor(UIColor.black, for: .normal)
        collectionButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        collectionButton.layer.borderWidth = 3
        collectionButton.layer.cornerRadius = 10
        collectionButton.layer.shadowColor = UIColor.black.cgColor
        collectionButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        collectionButton.layer.shadowRadius = 1
        collectionButton.layer.shadowOpacity = 1.0
        collectionButton.isUserInteractionEnabled = true
        collectionButton.isEnabled = true
        collectionButton.backgroundColor = UIColor.systemTeal
        collectionButton.layer.shouldRasterize = true
        collectionButton.layer.rasterizationScale = UIScreen.main.scale
        return collectionButton
    }()
    
    lazy var challengesButton: UIButton = {
        let challengesButton = UIButton()
        challengesButton.translatesAutoresizingMaskIntoConstraints = false
        challengesButton.alpha = 0.5
        challengesButton.tag = 1
        challengesButton.setTitle("Challenges", for: .normal)
        challengesButton.setTitleColor(UIColor.black, for: .normal)
        challengesButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        challengesButton.layer.borderWidth = 3
        challengesButton.layer.cornerRadius = 10
        challengesButton.layer.shadowColor = UIColor.black.cgColor
        challengesButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        challengesButton.layer.shadowRadius = 1
        challengesButton.layer.shadowOpacity = 1.0
        challengesButton.isUserInteractionEnabled = true
        challengesButton.isEnabled = false
        challengesButton.backgroundColor = UIColor.systemTeal
        challengesButton.layer.shouldRasterize = true
        challengesButton.layer.rasterizationScale = UIScreen.main.scale
        return challengesButton
    }()
    
    lazy var resetButton: UIButton = {
       let resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.alpha = 1
        resetButton.tag = 1
        resetButton.isUserInteractionEnabled = true
        resetButton.isEnabled = true
        resetButton.setTitle(" RESET (ADMIN) ", for: .normal)
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        resetButton.layer.borderWidth = 3
        resetButton.layer.cornerRadius = 10
        resetButton.layer.shadowColor = UIColor.black.cgColor
        resetButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        resetButton.layer.shadowRadius = 1
        resetButton.layer.shadowOpacity = 1.0
        resetButton.backgroundColor = UIColor.red
        resetButton.layer.shouldRasterize = true
        resetButton.layer.rasterizationScale = UIScreen.main.scale
        return resetButton
    }()
    
    lazy var addCoinButton: UIButton = {
       let addCoinButton = UIButton()
        addCoinButton.translatesAutoresizingMaskIntoConstraints = false
        addCoinButton.alpha = 1
        addCoinButton.tag = 1
        addCoinButton.isUserInteractionEnabled = true
        addCoinButton.isEnabled = true
        addCoinButton.setTitle("🪙 Add Coin", for: .normal)
        addCoinButton.setTitleColor(UIColor.black, for: .normal)
        addCoinButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        addCoinButton.layer.borderWidth = 3
        addCoinButton.layer.cornerRadius = 10
        addCoinButton.layer.shadowColor = UIColor.black.cgColor
        addCoinButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addCoinButton.layer.shadowRadius = 1
        addCoinButton.layer.shadowOpacity = 1.0
        addCoinButton.backgroundColor = UIColor.green
        addCoinButton.layer.shouldRasterize = true
        addCoinButton.layer.rasterizationScale = UIScreen.main.scale
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
        muteVibrationButton.alpha = 1
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
    
    //MARK: - setupSubviews:
    
    func setupSubviews() {
        menuView.addSubview(coverImageView)
        
        menuView.addSubview(titleLabel)
        menuView.addSubview(coinLabel)
        
        menuView.addSubview(playButton)
        menuView.addSubview(timeModeButton)
        menuView.addSubview(hardcoreModeButton)
        menuView.addSubview(collectionButton)
        menuView.addSubview(challengesButton)
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
            
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: menuView.layoutMarginsGuide.topAnchor, constant: 120),
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
            
            collectionButton.topAnchor.constraint(equalTo: hardcoreModeButton.bottomAnchor, constant: 50),
            collectionButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            collectionButton.heightAnchor.constraint(equalToConstant: 50),
            collectionButton.widthAnchor.constraint(equalToConstant: 120),
            
            challengesButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 10),
            challengesButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            challengesButton.heightAnchor.constraint(equalToConstant: 50),
            challengesButton.widthAnchor.constraint(equalToConstant: 120),
            
            resetButton.topAnchor.constraint(equalTo: challengesButton.bottomAnchor, constant: 50),
            resetButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 120),
            
            addCoinButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            addCoinButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            addCoinButton.heightAnchor.constraint(equalToConstant: 50),
            addCoinButton.widthAnchor.constraint(equalToConstant: 120),
            
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
}
