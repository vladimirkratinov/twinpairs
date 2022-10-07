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
//        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var myShadowView: UIImageView = {
        let myShadowView = UIImageView()
        myShadowView.translatesAutoresizingMaskIntoConstraints = false
        myShadowView.backgroundColor = .black
        myShadowView.alpha = 0.4
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
        unlockButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 24)
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
        selectButton.backgroundColor = UIColor(red: 0.28, green: 0.92, blue: 0.18, alpha: 1.00)
        selectButton.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 20)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: FigmaKey.gradientTexture2.rawValue)!)
        contentView.contentMode = .center
        
        contentView.layer.cornerRadius = 20
        myShadowView.layer.cornerRadius = 20
        
//        let borderWidth: CGFloat = 3
//        self.frame = frame.inset(by: UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50))
//        self.frame = frame.insetBy(dx: -borderWidth, dy: -borderWidth)
//        contentView.layer.borderColor = UIColor(red: 255, green: 255, blue: 235, alpha: 1).cgColor
//        contentView.layer.borderWidth = borderWidth
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath(roundedRect:
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
        
        NSLayoutConstraint.activate([
            unlockButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            unlockButton.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor),
            unlockButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            unlockButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            selectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            selectButton.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor),
            selectButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            selectButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            myLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            myImageView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 2),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            myShadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myShadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            myShadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
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
//        selectButton.backgroundColor = .green
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
