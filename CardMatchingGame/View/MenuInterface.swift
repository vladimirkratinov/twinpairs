//
//  MenuInterface.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/6.
//

import UIKit

class MenuInterface: UIView {
    
    var menuView: UIView = {
        let menuView = UIView()
        menuView.backgroundColor = UIColor.red
        return menuView
    }()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "psyduck")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "MATCH PAIR GAME (v.0.2)"
        titleLabel.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        return titleLabel
    }()
    
    var playButton: UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        playButton.layer.borderWidth = 3
        playButton.layer.cornerRadius = 10
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        playButton.layer.shadowRadius = 1
        playButton.layer.shadowOpacity = 1.0
        playButton.isUserInteractionEnabled = true
        playButton.backgroundColor = UIColor.systemOrange
        playButton.layer.shouldRasterize = true
        playButton.layer.rasterizationScale = UIScreen.main.scale
        return playButton
    }()
    
    var otherButton: UIButton = {
       let otherButton = UIButton()
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.alpha = 1
        otherButton.isUserInteractionEnabled = true
        otherButton.isEnabled = true
        otherButton.setTitle("Other", for: .normal)
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
            
            playButton.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            otherButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            otherButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            otherButton.heightAnchor.constraint(equalToConstant: 50),
            otherButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}
