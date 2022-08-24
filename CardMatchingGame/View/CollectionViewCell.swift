//
//  CollectionViewCell.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini

class CollectionViewCell: GeminiCell {
    
    static let identifier = "CollectionViewCell"
    let palette = Palette()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var lockerImageView: UIImageView = {
        let lockerImageView = UIImageView()
        lockerImageView.image = UIImage(systemName: "lock.fill")
        lockerImageView.tintColor = UIColor.systemPink
        lockerImageView.contentMode = .scaleAspectFill
        lockerImageView.clipsToBounds = false
        return lockerImageView
    }()
    
    var unlockButton: UIButton = {
        let unlockButton = UIButton()
        unlockButton.alpha = 1
//        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.setTitle(" Unlock ", for: .normal)
        unlockButton.backgroundColor = UIColor.systemGreen
        unlockButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        unlockButton.setTitleColor(UIColor.black, for: .normal)
        unlockButton.layer.borderColor = UIColor.black.cgColor
        unlockButton.layer.borderWidth = 3
        unlockButton.layer.cornerRadius = 10
        unlockButton.isUserInteractionEnabled = true
        unlockButton.layer.shadowColor = UIColor.black.cgColor
        unlockButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        unlockButton.layer.shadowRadius = 1
        unlockButton.layer.shadowOpacity = 1.0
        unlockButton.layer.shouldRasterize = true
        unlockButton.layer.rasterizationScale = UIScreen.main.scale
        return unlockButton
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: ImageKey.CollectionViewCellBackground.rawValue)!)
        contentView.contentMode = .center

        contentView.layer.cornerRadius = 20
//        contentView.layer.borderWidth = 5.0
        contentView.layer.borderColor = UIColor.black.cgColor

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        contentView.layer.shadowRadius = 2.0
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath(roundedRect:
                                                        self.bounds,
                                                    cornerRadius:
                                                        self.contentView.layer.cornerRadius).cgPath
        
        lockerImageView.layer.shadowColor = UIColor.black.cgColor
        lockerImageView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lockerImageView.layer.shadowRadius = 0.5
        lockerImageView.layer.shadowOpacity = 0.5
        lockerImageView.layer.masksToBounds = false
        lockerImageView.layer.shadowPath = UIBezierPath(roundedRect:
                                                        self.bounds,
                                                    cornerRadius:
                                                        self.contentView.layer.cornerRadius).cgPath
        
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(lockerImageView)
        contentView.addSubview(unlockButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 0,
                               y: contentView.frame.size.height-50,
                               width: contentView.frame.size.width-10,
                               height: 50)
        
        myImageView.frame = CGRect(x: 0,
                                   y: 10,
                                   width: contentView.frame.size.width-10,
                                   height: contentView.frame.size.height-50)
        
        lockerImageView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentView.frame.size.width/2,
                                   height: contentView.frame.size.height/2)
        
        unlockButton.frame = CGRect(x: contentView.frame.size.width/3,
                                   y: contentView.frame.size.height/2 + 130,
                                   width: 120,
                                   height: 44)
        
        unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
    
    public func configure(label: String, image: UIImage) {
        myLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 30)
        myLabel.text = label
        myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
        lockerImageView.isHidden = false
    }
    
    @objc func unlockButtonTapped(_ sender: UIButton) {
        sender.bounce(sender)
        print("unlock button tapped!")
        if Properties.collectionIsLocked {
            print("unlocked!")
            lockerImageView.isHidden = true
            Properties.collectionIsLocked = false
        } else {
            print("locked!")
            lockerImageView.isHidden = false
            Properties.collectionIsLocked = true
        }
    
    }
    
}
