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
    
    static let identifier = "CollectionViewCell"
    let palette = Palette()
    
    var myImageView: UIImageView = {
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
        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.setTitle(" Unlock ", for: .normal)
        unlockButton.backgroundColor = UIColor.systemGreen
        unlockButton.titleLabel?.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
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
    
    weak var delegate: CollectionViewCellDelegate?

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
        
        unlockButton.frame = CGRect(x: contentView.frame.size.width/5,
                                    y: contentView.frame.size.height/1.3,
                                   width: 100,
                                   height: 44)
        
        NSLayoutConstraint.activate([
            unlockButton.bottomAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: -5),
            unlockButton.centerXAnchor.constraint(equalTo: myLabel.centerXAnchor),
            unlockButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            unlockButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
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


