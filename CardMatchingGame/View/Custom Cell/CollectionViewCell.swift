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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var myShadowView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.alpha = 0.4
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var lockerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: FigmaKey.lock.rawValue)
        imageView.tintColor = UIColor.systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    var unlockButton: UIButton = {
        let button = UIButton()
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Unlock ", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 24)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.tag += 1
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1.0
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        return button
    }()
    
    var selectButton: UIButton = {
        let button = UIButton()
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Select ", for: .normal)
        button.backgroundColor = UIColor(red: 0.28, green: 0.92, blue: 0.18, alpha: 1.00)
        button.titleLabel?.font = UIFont(name: FontKey.staatliches.rawValue, size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.tag += 1
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1.0
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        return button
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
