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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.contentMode = .center
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    public func configure(label: String, image: UIImage) {
        myImageView.image = image
        myImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
