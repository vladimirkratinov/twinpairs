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
        myShadowView.image = UIImage(named: "cardFrame")
        myShadowView.contentMode = .scaleToFill
        myShadowView.clipsToBounds = true
        return myShadowView
    }()
    
    var lockerImageView: UIImageView = {
        let lockerImageView = UIImageView()
        lockerImageView.translatesAutoresizingMaskIntoConstraints = false
        lockerImageView.image = UIImage(named: ImageKey.lock2.rawValue)
//        lockerImageView.backgroundColor = .blue
        lockerImageView.tintColor = UIColor.systemPink
        lockerImageView.contentMode = .scaleToFill
        lockerImageView.clipsToBounds = false
        return lockerImageView
    }()
    
    var unlockButton: UIButton = {
        let unlockButton = UIButton()
        unlockButton.alpha = 1
        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.setTitle(" Unlock ", for: .normal)
        unlockButton.backgroundColor = UIColor.systemGreen
        unlockButton.titleLabel?.font = UIFont(name: FontKey.AmericanTypewriterBold.rawValue, size: 20)
        unlockButton.setTitleColor(UIColor.black, for: .normal)
        unlockButton.layer.borderColor = UIColor.black.cgColor
        unlockButton.tag += 1
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
    
    var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: ImageKey.wood2.rawValue)!)
        contentView.contentMode = .center

//        contentView.layer.borderWidth = 5.0
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
        
        myShadowView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)
        
        lockerImageView.frame = CGRect(x: 0,
                                       y: 0,
                                   width: contentView.frame.size.width/2,
                                   height: contentView.frame.size.height/2)
        
        unlockButton.frame = CGRect(x: contentView.frame.size.width/5,
                                    y: contentView.frame.size.height/1.3,
                                   width: 100,
                                   height: 44)
        
        NSLayoutConstraint.activate([
            unlockButton.bottomAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: -5),
            unlockButton.centerXAnchor.constraint(equalTo: myLabel.centerXAnchor),
            unlockButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            unlockButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            lockerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            lockerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            lockerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            lockerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
    
    public func configure(label: String, image: UIImage) {
        myLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 20)
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
}


