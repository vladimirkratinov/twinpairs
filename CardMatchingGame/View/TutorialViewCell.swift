//
//  TutorialCell.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/10/28.
//

import UIKit
import Gemini

class TutorialViewCell: GeminiCell {
    
    static let identifier = "TutorialViewCell"
    let palette = Palette()
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: FigmaKey.cardCover1.rawValue)
//        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
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
        contentView.backgroundColor = .white
        contentView.contentMode = .center
        
//        contentView.layer.cornerRadius = 20
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        contentView.layer.shadowRadius = 5
//        contentView.layer.shadowOpacity = 0.5
//        contentView.layer.masksToBounds = false
//        contentView.layer.shadowPath = UIBezierPath(roundedRect:
//                                                        self.bounds,
//                                                    cornerRadius:
//                                                        self.contentView.layer.cornerRadius).cgPath
 
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor),
            myLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            myLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
//            myImageView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 2),
//            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
//            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    public func configure(label: String, image: UIImage) {
        myLabel.font = UIFont(name: FontKey.staatliches.rawValue, size: 26)
        myLabel.text = label
        myLabel.adjustsFontSizeToFitWidth = true
        myImageView.image = image
        myImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
