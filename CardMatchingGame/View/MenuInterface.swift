//
//  MenuInterface.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/6.
//

import UIKit

class MenuInterface: UIView {
    
    let palette = Palette()
    
    var menuView: UIView = {
        let menuView = UIView()
        return menuView
    }()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.3
        backgroundImageView.image = UIImage(named: "LaunchScreen2")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "MATCH PAIR GAME (v.0.4)"
        titleLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return titleLabel
    }()
    
    lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Classic", for: .normal)
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
    
    lazy var otherButton: UIButton = {
       let otherButton = UIButton()
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.alpha = 1
        otherButton.isUserInteractionEnabled = true
        otherButton.isEnabled = true
        otherButton.setTitle("Reset", for: .normal)
        otherButton.setTitleColor(UIColor.black, for: .normal)
        otherButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        otherButton.layer.borderWidth = 3
        otherButton.layer.cornerRadius = 10
        otherButton.layer.shadowColor = UIColor.black.cgColor
        otherButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        otherButton.layer.shadowRadius = 1
        otherButton.layer.shadowOpacity = 1.0
        otherButton.backgroundColor = UIColor.gray
        otherButton.layer.shouldRasterize = true
        otherButton.layer.rasterizationScale = UIScreen.main.scale
        return otherButton
    }()
    
    func setupSubviews() {
        menuView.addSubview(titleLabel)
        menuView.addSubview(playButton)
        menuView.addSubview(timeModeButton)
        menuView.addSubview(hardcoreModeButton)
        menuView.addSubview(collectionButton)
        menuView.addSubview(challengesButton)
        menuView.addSubview(otherButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: menuView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: menuView.layoutMarginsGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
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
            
            otherButton.topAnchor.constraint(equalTo: challengesButton.bottomAnchor, constant: 50),
            otherButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            otherButton.heightAnchor.constraint(equalToConstant: 50),
            otherButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
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
