//
//  UIView.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

class UserInterface: UIView {
    let prop = Properties()
    let defaults = UserDefaults.standard
    
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
            
            UIColor.systemBlue.cgColor,
            UIColor.systemGray.cgColor,
            UIColor.systemBrown.cgColor
        ]
        gameView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - Labels:

    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .left
        timeLabel.text = "Time: 0"
        timeLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return timeLabel
    }()
    
    var pairsLabel: UILabel = {
        let pairsLabel = UILabel()
        pairsLabel.translatesAutoresizingMaskIntoConstraints = false
        pairsLabel.textAlignment = .right
        pairsLabel.text = "Pairs: 0"
        pairsLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return pairsLabel
    }()

    var flipsLabel: UILabel = {
        let flipsLabel = UILabel()
        flipsLabel.translatesAutoresizingMaskIntoConstraints = false
        flipsLabel.textAlignment = .right
        flipsLabel.text = "Flips: 0"
        flipsLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return flipsLabel
    }()
    
    var statisticsLabel: UILabel = {
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
    
    var bestResultLabel: UILabel = {
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

    var gameOverLabel: UILabel = {
        let gameOverLabel = UILabel()
        gameOverLabel.alpha = 0
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "GAME OVER!"
        gameOverLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 55)
        gameOverLabel.textColor = UIColor.yellow
        //shadows {
        gameOverLabel.layer.shadowColor = UIColor.black.cgColor
        gameOverLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        gameOverLabel.layer.shadowRadius = 1
        gameOverLabel.layer.shadowOpacity = 1.0
        gameOverLabel.layer.shouldRasterize = true
        gameOverLabel.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        return gameOverLabel
    }()

    var nextLevelLabel: UILabel = {
        let nextLevelLabel = UILabel()
        nextLevelLabel.alpha = 0
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        nextLevelLabel.textAlignment = .center
        nextLevelLabel.text = "NEXT LEVEL!"
        nextLevelLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 45)
        nextLevelLabel.textColor = UIColor.green
        //shadows {
        nextLevelLabel.layer.shadowColor = UIColor.black.cgColor
        nextLevelLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        nextLevelLabel.layer.shadowRadius = 1
        nextLevelLabel.layer.shadowOpacity = 1.0
        nextLevelLabel.layer.shouldRasterize = true
        nextLevelLabel.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        return nextLevelLabel
    }()
    
    //MARK: - Buttons:
    
    var restartButton: UIButton = {
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

    var backToMenuButton: UIButton = {
        let backToMenuButton = UIButton()
        backToMenuButton.isHidden = true
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
        //shadows {
        backToMenuButton.layer.shadowColor = UIColor.black.cgColor
        backToMenuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        backToMenuButton.layer.shadowRadius = 1
        backToMenuButton.layer.shadowOpacity = 1.0
        backToMenuButton.layer.shouldRasterize = true
        backToMenuButton.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        return backToMenuButton
    }()

    var menuButton: UIButton = {
        let menuButton = UIButton()
        menuButton.alpha = 1
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setTitle(" Back ", for: .normal)
        menuButton.backgroundColor = UIColor.systemPink
        menuButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        menuButton.setTitleColor(UIColor.black, for: .normal)
        menuButton.layer.borderColor = UIColor.black.cgColor
        menuButton.layer.borderWidth = 3
        menuButton.layer.cornerRadius = 10
        menuButton.isUserInteractionEnabled = true
        //shadows {
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        menuButton.layer.shadowRadius = 1
        menuButton.layer.shadowOpacity = 1.0
        menuButton.layer.shouldRasterize = true
        menuButton.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        return menuButton
    }()

    var muteButton: UIButton = {
        let muteButton = UIButton()
        let defaults = UserDefaults.standard
        muteButton.alpha = 1
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        muteButton.setTitle(" Mute ", for: .normal)
        muteButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        muteButton.setTitleColor(UIColor.black, for: .normal)
        muteButton.layer.borderColor = UIColor.black.cgColor
        muteButton.layer.borderWidth = 3
        muteButton.layer.cornerRadius = 10
        muteButton.isUserInteractionEnabled = true
        muteButton.backgroundColor = defaults.colorForKey(key: ColorKey.myColor.rawValue)
        //shadows {
        muteButton.layer.shadowColor = UIColor.black.cgColor
        muteButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        muteButton.layer.shadowRadius = 1
        muteButton.layer.shadowOpacity = 1.0
        muteButton.layer.shouldRasterize = true
        muteButton.layer.rasterizationScale = UIScreen.main.scale
        //shadows }
        return muteButton
    }()
    
    //MARK: - Subview:
    
    func setupSubviews() {
        gameView.addSubview(buttonsView)
        gameView.addSubview(statisticsView)
        
        gameView.addSubview(timeLabel)
        gameView.addSubview(flipsLabel)
        gameView.addSubview(pairsLabel)
        
        statisticsView.addSubview(bestResultLabel)
        statisticsView.addSubview(statisticsLabel)
        
        gameView.addSubview(gameOverLabel)
        gameView.addSubview(nextLevelLabel)
        
        gameView.addSubview(restartButton)
        gameView.addSubview(backToMenuButton)
        gameView.addSubview(menuButton)
        gameView.addSubview(muteButton)
    }
    
    //MARK: - Constraints:
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            buttonsView.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: -20),
            
            statisticsView.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 5),
            statisticsView.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 20),
            statisticsView.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -20),
            statisticsView.bottomAnchor.constraint(equalTo: bestResultLabel.bottomAnchor, constant: 10),
            
            statisticsLabel.topAnchor.constraint(equalTo: statisticsView.topAnchor, constant: 10),
            statisticsLabel.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor),

            bestResultLabel.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 0),
            bestResultLabel.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor),

            timeLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.leadingAnchor),

            flipsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            flipsLabel.trailingAnchor.constraint(equalTo: gameView.layoutMarginsGuide.trailingAnchor),

            pairsLabel.topAnchor.constraint(equalTo: gameView.layoutMarginsGuide.topAnchor),
            pairsLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

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

            menuButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor, constant: -100),
            menuButton.bottomAnchor.constraint(equalTo: gameView.layoutMarginsGuide.bottomAnchor, constant: -10),
            menuButton.widthAnchor.constraint(equalToConstant: 120),

            muteButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor, constant: 100),
            muteButton.bottomAnchor.constraint(equalTo: gameView.layoutMarginsGuide.bottomAnchor, constant: -10),
            muteButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}
