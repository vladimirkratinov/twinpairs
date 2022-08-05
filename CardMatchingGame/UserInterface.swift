//
//  UIView.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

class UserInterface: UIView {
    
    var myView: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.red
        return myView
    }()
    
    var buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 3
        return buttonsView
    }()
    
//    var cardButton: UIButton = {
//        let cardButton = UIButton(type: .system)
//        cardButton.layer.borderWidth = 10
//        cardButton.layer.cornerRadius = 10
//        cardButton.layer.borderColor = UIColor.systemBrown.cgColor
//        cardButton.tintColor = UIColor.darkGray
//        cardButton.setImage(UIImage(named: "Spider"), for: .normal)
//        cardButton.imageView?.contentMode = .scaleAspectFit
//        cardButton.imageView?.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9)       //scale Size
//        cardButton.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!)
//        
//        return cardButton
//    }()
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = myView.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor,
            UIColor.systemRed.cgColor
        ]
        //       gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        //       gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        //       gradientLayer.locations = [1,0]

        myView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - Labels:

    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .left
        timeLabel.text = "Time: "
        timeLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 25)
        return timeLabel
    }()

    var flipsLabel: UILabel = {
        let flipsLabel = UILabel()
        flipsLabel.translatesAutoresizingMaskIntoConstraints = false
        flipsLabel.textAlignment = .right
        flipsLabel.text = "Flips: 0"
        flipsLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 25)
        return flipsLabel
    }()

    var gameOverLabel: UILabel = {
        let gameOverLabel = UILabel()
        gameOverLabel.alpha = 0
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "GAME OVER!"
        gameOverLabel.font = UIFont(name: "Baskerville-SemiBold", size: 55)
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
        nextLevelLabel.font = UIFont(name: "Baskerville-SemiBold", size: 45)
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

    var pairsLabel: UILabel = {
        let pairsLabel = UILabel()
        pairsLabel.translatesAutoresizingMaskIntoConstraints = false
        pairsLabel.textAlignment = .right
        pairsLabel.text = "Pairs: 0"
        pairsLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 25)
        return pairsLabel
    }()
    
    //MARK: - Buttons:
    
    var restartButton: UIButton = {
        let restartButton = UIButton()
        restartButton.alpha = 0
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle(" Restart ", for: .normal)
        restartButton.backgroundColor = UIColor.red
        restartButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
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
        backToMenuButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
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
        menuButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
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
        muteButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 25)
        muteButton.setTitleColor(UIColor.black, for: .normal)
        muteButton.layer.borderColor = UIColor.black.cgColor
        muteButton.layer.borderWidth = 3
        muteButton.layer.cornerRadius = 10
        muteButton.isUserInteractionEnabled = true
        muteButton.backgroundColor = defaults.colorForKey(key: "myColor")
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
        myView.addSubview(buttonsView)
        
        myView.addSubview(timeLabel)
        myView.addSubview(flipsLabel)
        myView.addSubview(pairsLabel)
        myView.addSubview(gameOverLabel)
        myView.addSubview(nextLevelLabel)
        
        myView.addSubview(restartButton)
        myView.addSubview(backToMenuButton)
        myView.addSubview(menuButton)
        myView.addSubview(muteButton)
    }
    
    //MARK: - Constraints:
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            buttonsView.leadingAnchor.constraint(equalTo: myView.layoutMarginsGuide.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: myView.layoutMarginsGuide.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: -5),

            timeLabel.topAnchor.constraint(equalTo: myView.layoutMarginsGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: myView.layoutMarginsGuide.leadingAnchor),

            flipsLabel.topAnchor.constraint(equalTo: myView.layoutMarginsGuide.topAnchor),
            flipsLabel.trailingAnchor.constraint(equalTo: myView.layoutMarginsGuide.trailingAnchor),

            pairsLabel.topAnchor.constraint(equalTo: myView.layoutMarginsGuide.topAnchor),
            pairsLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor),

            gameOverLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            gameOverLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor),

            nextLevelLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            nextLevelLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor),

            restartButton.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: myView.centerYAnchor, constant: 100),
            restartButton.widthAnchor.constraint(equalToConstant: 150),

            backToMenuButton.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            backToMenuButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 10),
            backToMenuButton.widthAnchor.constraint(equalToConstant: 150),

            menuButton.centerXAnchor.constraint(equalTo: myView.centerXAnchor, constant: -100),
            menuButton.bottomAnchor.constraint(equalTo: myView.layoutMarginsGuide.bottomAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 150),

            muteButton.centerXAnchor.constraint(equalTo: myView.centerXAnchor, constant: 100),
            muteButton.bottomAnchor.constraint(equalTo: myView.layoutMarginsGuide.bottomAnchor),
            muteButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
}
