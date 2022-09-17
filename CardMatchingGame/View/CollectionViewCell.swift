//
//  CollectionViewCell.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini

protocol CollectionViewCellDelegate: AnyObject {
    func touchUpInside(delegatedFrom cell: CollectionViewCell)
    func selectButtonTapped(delegatedFrom cell: CollectionViewCell)
}

class CollectionViewCell: GeminiCell {
    
    weak var delegate: CollectionViewCellDelegate?
    static let identifier = "CollectionViewCell"
    let palette = Palette()
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var myShadowView: UIImageView = {
        let myShadowView = UIImageView()
//        myShadowView.image = UIImage(named: "cardFrame")
        myShadowView.contentMode = .scaleToFill
        myShadowView.clipsToBounds = true
        return myShadowView
    }()
    
    var lockerImageView: UIImageView = {
        let lockerImageView = UIImageView()
        lockerImageView.translatesAutoresizingMaskIntoConstraints = false
        lockerImageView.image = UIImage(named: FigmaKey.lock.rawValue)
//        lockerImageView.backgroundColor = .blue
        lockerImageView.tintColor = UIColor.systemPink
        lockerImageView.contentMode = .scaleAspectFit
        lockerImageView.clipsToBounds = false
        return lockerImageView
    }()
    
    var unlockButton: UIButton = {
        let unlockButton = UIButton()
        unlockButton.alpha = 1
        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.setTitle(" Unlock ", for: .normal)
        unlockButton.backgroundColor = UIColor.systemGreen
        unlockButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 14)
        unlockButton.titleLabel?.adjustsFontSizeToFitWidth = true
        unlockButton.setTitleColor(UIColor.black, for: .normal)
        unlockButton.layer.borderColor = UIColor.black.cgColor
        unlockButton.tag += 1
        unlockButton.layer.borderWidth = 0
        unlockButton.layer.cornerRadius = 10
        unlockButton.isUserInteractionEnabled = true
        unlockButton.layer.shadowColor = UIColor.black.cgColor
        unlockButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        unlockButton.layer.shadowRadius = 3
        unlockButton.layer.shadowOpacity = 1.0
        unlockButton.layer.shouldRasterize = true
        unlockButton.layer.rasterizationScale = UIScreen.main.scale
        return unlockButton
    }()
    
    var selectButton: UIButton = {
        let selectButton = UIButton()
        selectButton.alpha = 1
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.setTitle(" Select ", for: .normal)
        selectButton.backgroundColor = UIColor.systemGreen
        selectButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 14)
        selectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        selectButton.setTitleColor(UIColor.black, for: .normal)
        selectButton.layer.borderColor = UIColor.black.cgColor
        selectButton.tag += 1
        selectButton.layer.borderWidth = 0
        selectButton.layer.cornerRadius = 10
        selectButton.isUserInteractionEnabled = true
        selectButton.layer.shadowColor = UIColor.black.cgColor
        selectButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        selectButton.layer.shadowRadius = 3
        selectButton.layer.shadowOpacity = 1.0
        selectButton.layer.shouldRasterize = true
        selectButton.layer.rasterizationScale = UIScreen.main.scale
        return selectButton
    }()
    
    var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: FigmaKey.paperTexture.rawValue)!)
        contentView.contentMode = .center

        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 20
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
                
        myShadowView.layer.shadowColor = UIColor.black.cgColor
        myShadowView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        myShadowView.layer.shadowRadius = 0.5
        myShadowView.layer.shadowOpacity = 0.5
        myShadowView.layer.masksToBounds = false
        myShadowView.layer.shadowPath = UIBezierPath(roundedRect:
                                                        self.bounds,
                                                    cornerRadius:
                                                        self.contentView.layer.cornerRadius).cgPath
        
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(myShadowView)
        contentView.addSubview(lockerImageView)
        contentView.addSubview(unlockButton)
        contentView.addSubview(selectButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 0,
                               y: 5, //contentView.frame.size.height-50
                               width: contentView.frame.size.width,
                               height: 20)
        
        myImageView.frame = CGRect(x: 0,
                                   y: 30,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height-60)
        
        myShadowView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)
        
        lockerImageView.frame = CGRect(x: 0,
                                       y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)
        
        unlockButton.frame = CGRect(x: contentView.frame.size.width/5,
                                    y: contentView.frame.size.height/1,
                                   width: 100,
                                   height: 44)
        
        selectButton.frame = CGRect(x: contentView.frame.size.width/5,
                                    y: contentView.frame.size.height/1,
                                   width: 100,
                                   height: 44)
        
        NSLayoutConstraint.activate([
            unlockButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            unlockButton.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor),
            unlockButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 65),
            unlockButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            selectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            selectButton.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor),
            selectButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 65),
            selectButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            lockerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lockerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lockerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    public func configure(label: String, image: UIImage) {
        myLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 14)
        myLabel.text = label
        myLabel.adjustsFontSizeToFitWidth = true
        myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
        lockerImageView.image = UIImage(systemName: "lock.fill")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    @objc func unlockButtonTapped(_ sender: UIButton) {
        sender.bounce(sender)
        delegate?.touchUpInside(delegatedFrom: self)
    }
    
    @objc func selectButtonTapped(_ sender: UIButton) {
        sender.bounce(sender)
        delegate?.selectButtonTapped(delegatedFrom: self)
        
    }
}


