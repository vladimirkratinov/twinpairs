//
//  ShopInterface.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022-09-30.
//

import UIKit

class ShopInterface: UIView {
    
    let palette = Palette()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: FigmaKey.backgroundMenu.rawValue)!)
        return view
    }()

        var scrollView: UIScrollView = {
            let scrollView = UIScrollView(frame: .zero)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.isUserInteractionEnabled = true
            scrollView.isScrollEnabled = true
//            scrollView.backgroundColor = .green
            return scrollView
        }()

    var shopView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.alpha = 1
        imageView.image = UIImage(named: FigmaKey.backgroundMenu.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "card sets:"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 55)
        return label
    }()
    
    lazy var title2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "card covers:"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 55)
        return label
    }()
    
    lazy var cardSet1DescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.alpha = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "Stamps of Canada"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var cardSet2DescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.alpha = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "Stamps of Ukraine"
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Block 1:
    
    lazy var contentBlock1: UIView = {
        let view = UIView()
        setupViewAppearence(view)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "ShopBlockBackground")!).withAlphaComponent(1)
        return view
    }()
    
    lazy var verticalSeparatorInBlock1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardSet1ImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "set7_canada02"), for: .normal)
        return button
    }()
    
    lazy var cardSet2ImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "set8_ukraine01"), for: .normal)
        return button
    }()
    
    lazy var cardSet1UnlockButton: UIButton = {
        let button = UIButton()
        setupButtonAppearence(button)
        button.setTitle("unlock", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cardSet2UnlockButton: UIButton = {
        let button = UIButton()
        setupButtonAppearence(button)
        button.setTitle("unlock", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Block 2:
    
    lazy var contentBlock2: UIView = {
        let view = UIView()
        setupViewAppearence(view)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "ShopBlockBackground")!).withAlphaComponent(1)
        return view
    }()
    
    lazy var verticalSeparatorInBlock2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var coverSet1ImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "shop_cover_1"), for: .normal)
        return button
    }()
    
    lazy var coverSet2ImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "shop_cover_2"), for: .normal)
        return button
    }()
    
    lazy var coverSet1UnlockButton: UIButton = {
        let button = UIButton()
        setupButtonAppearence(button)
        button.setTitle("unlock", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var coverSet2UnlockButton: UIButton = {
        let button = UIButton()
        setupButtonAppearence(button)
        button.setTitle("unlock", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setupSubviews() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(shopView)

//        shopView.addSubview(contentBlock1)
//        shopView.addSubview(contentBlock2)
//        shopView.addSubview(title1)
//        shopView.addSubview(title2)
        
        scrollView.addSubview(contentBlock1)
        scrollView.addSubview(contentBlock2)
        scrollView.addSubview(title1)
        scrollView.addSubview(title2)
        
        contentBlock1.addSubview(verticalSeparatorInBlock1)
        contentBlock1.addSubview(cardSet1ImageButton)
        contentBlock1.addSubview(cardSet1UnlockButton)
        contentBlock1.addSubview(cardSet2ImageButton)
        contentBlock1.addSubview(cardSet2UnlockButton)
        contentBlock1.addSubview(cardSet1DescriptionLabel)
        contentBlock1.addSubview(cardSet2DescriptionLabel)
        
        contentBlock2.addSubview(verticalSeparatorInBlock2)
        contentBlock2.addSubview(coverSet1ImageButton)
        contentBlock2.addSubview(coverSet1UnlockButton)
        contentBlock2.addSubview(coverSet2ImageButton)
        contentBlock2.addSubview(coverSet2UnlockButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            shopView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            shopView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            shopView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            shopView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            shopView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            //MARK: - title 1:
            
            title1.topAnchor.constraint(equalTo: shopView.layoutMarginsGuide.topAnchor, constant: 0),
            title1.leadingAnchor.constraint(equalTo: shopView.leadingAnchor, constant: 15),
            
            contentBlock1.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 5),
            contentBlock1.leadingAnchor.constraint(equalTo: shopView.leadingAnchor, constant: 10),
            contentBlock1.trailingAnchor.constraint(equalTo: shopView.trailingAnchor, constant: -10),
            contentBlock1.heightAnchor.constraint(lessThanOrEqualToConstant: 270),
            
            verticalSeparatorInBlock1.topAnchor.constraint(equalTo: contentBlock1.topAnchor),
            verticalSeparatorInBlock1.bottomAnchor.constraint(equalTo: contentBlock1.bottomAnchor),
            verticalSeparatorInBlock1.centerXAnchor.constraint(equalTo: contentBlock1.centerXAnchor),
            verticalSeparatorInBlock1.widthAnchor.constraint(equalToConstant: 5),
            
            cardSet1DescriptionLabel.centerXAnchor.constraint(equalTo: cardSet1ImageButton.centerXAnchor),
            cardSet1DescriptionLabel.centerYAnchor.constraint(equalTo: cardSet1ImageButton.centerYAnchor),
            
            cardSet2DescriptionLabel.centerXAnchor.constraint(equalTo: cardSet2ImageButton.centerXAnchor),
            cardSet2DescriptionLabel.centerYAnchor.constraint(equalTo: cardSet2ImageButton.centerYAnchor),
            
            cardSet1ImageButton.topAnchor.constraint(equalTo: contentBlock1.topAnchor, constant: 10),
            cardSet1ImageButton.leadingAnchor.constraint(equalTo: contentBlock1.leadingAnchor, constant: 10),
            cardSet1ImageButton.trailingAnchor.constraint(equalTo: verticalSeparatorInBlock1.leadingAnchor, constant: -10),
            cardSet1ImageButton.bottomAnchor.constraint(equalTo: contentBlock1.bottomAnchor, constant: -55),

            cardSet2ImageButton.topAnchor.constraint(equalTo: contentBlock1.topAnchor, constant: 10),
            cardSet2ImageButton.leadingAnchor.constraint(equalTo: verticalSeparatorInBlock1.trailingAnchor, constant: 10),
            cardSet2ImageButton.trailingAnchor.constraint(equalTo: contentBlock1.trailingAnchor, constant: -10),
            cardSet2ImageButton.bottomAnchor.constraint(equalTo: contentBlock1.bottomAnchor, constant: -55),
            
            cardSet1UnlockButton.topAnchor.constraint(equalTo: cardSet1ImageButton.bottomAnchor, constant: 5),
            cardSet1UnlockButton.bottomAnchor.constraint(equalTo: contentBlock1.bottomAnchor, constant: -7),
            cardSet1UnlockButton.leadingAnchor.constraint(equalTo: contentBlock1.leadingAnchor, constant: 30),
            cardSet1UnlockButton.trailingAnchor.constraint(equalTo: verticalSeparatorInBlock1.leadingAnchor, constant: -30),
            
            cardSet2UnlockButton.topAnchor.constraint(equalTo: cardSet1ImageButton.bottomAnchor, constant: 5),
            cardSet2UnlockButton.bottomAnchor.constraint(equalTo: contentBlock1.bottomAnchor, constant: -7),
            cardSet2UnlockButton.leadingAnchor.constraint(equalTo: verticalSeparatorInBlock1.trailingAnchor, constant: 30),
            cardSet2UnlockButton.trailingAnchor.constraint(equalTo: contentBlock1.trailingAnchor, constant: -30),
            
            //MARK: - title 2:
            
            title2.topAnchor.constraint(equalTo: contentBlock1.bottomAnchor, constant: 20),
            title2.leadingAnchor.constraint(equalTo: shopView.leadingAnchor, constant: 15),

            contentBlock2.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 5),
            contentBlock2.leadingAnchor.constraint(equalTo: shopView.leadingAnchor, constant: 10),
            contentBlock2.trailingAnchor.constraint(equalTo: shopView.trailingAnchor, constant: -10),
            contentBlock2.heightAnchor.constraint(lessThanOrEqualToConstant: 270),
            
            verticalSeparatorInBlock2.topAnchor.constraint(equalTo: contentBlock2.topAnchor),
            verticalSeparatorInBlock2.bottomAnchor.constraint(equalTo: contentBlock2.bottomAnchor),
            verticalSeparatorInBlock2.centerXAnchor.constraint(equalTo: contentBlock2.centerXAnchor),
            verticalSeparatorInBlock2.widthAnchor.constraint(equalToConstant: 5),
            
            coverSet1ImageButton.topAnchor.constraint(equalTo: contentBlock2.topAnchor, constant: 10),
            coverSet1ImageButton.leadingAnchor.constraint(equalTo: contentBlock2.leadingAnchor, constant: 10),
            coverSet1ImageButton.trailingAnchor.constraint(equalTo: verticalSeparatorInBlock2.leadingAnchor, constant: -10),
            coverSet1ImageButton.bottomAnchor.constraint(equalTo: contentBlock2.bottomAnchor, constant: -55),

            coverSet2ImageButton.topAnchor.constraint(equalTo: contentBlock2.topAnchor, constant: 10),
            coverSet2ImageButton.leadingAnchor.constraint(equalTo: verticalSeparatorInBlock2.trailingAnchor, constant: 10),
            coverSet2ImageButton.trailingAnchor.constraint(equalTo: contentBlock2.trailingAnchor, constant: -10),
            coverSet2ImageButton.bottomAnchor.constraint(equalTo: contentBlock2.bottomAnchor, constant: -55),
            
            coverSet1UnlockButton.topAnchor.constraint(equalTo: coverSet1ImageButton.bottomAnchor, constant: 5),
            coverSet1UnlockButton.bottomAnchor.constraint(equalTo: contentBlock2.bottomAnchor, constant: -7),
            coverSet1UnlockButton.leadingAnchor.constraint(equalTo: contentBlock2.leadingAnchor, constant: 30),
            coverSet1UnlockButton.trailingAnchor.constraint(equalTo: verticalSeparatorInBlock2.leadingAnchor, constant: -30),
            
            coverSet2UnlockButton.topAnchor.constraint(equalTo: coverSet2ImageButton.bottomAnchor, constant: 5),
            coverSet2UnlockButton.bottomAnchor.constraint(equalTo: contentBlock2.bottomAnchor, constant: -7),
            coverSet2UnlockButton.leadingAnchor.constraint(equalTo: verticalSeparatorInBlock2.trailingAnchor, constant: 30),
            coverSet2UnlockButton.trailingAnchor.constraint(equalTo: contentBlock2.trailingAnchor, constant: -30),
        ])
    }
    
    func setupViewAppearence(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupButtonAppearence(_ thisButton: UIButton) {
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
        thisButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 23)
        thisButton.backgroundColor = palette.shopUnlockButtonOrange
        thisButton.layer.shouldRasterize = true
        thisButton.layer.rasterizationScale = UIScreen.main.scale
    }
}
