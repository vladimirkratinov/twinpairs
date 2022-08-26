//
//  CardListViewCell.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/18.
//

import UIKit
import Gemini

class CardListViewCell: GeminiCell {
    
    static let identifier = "CardListViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 10,
                               y: contentView.frame.size.height-50,
                               width: contentView.frame.size.width-10,
                               height: 50)
        
        myImageView.frame = CGRect(x: 10,
                                   y: 10,
                                   width: contentView.frame.size.width-10,
                                   height: contentView.frame.size.height-50)
    }
    
    public func configure(label: String, image: UIImage) {
//        myLabel.text = label                                  //cut label names in cardlistView
        myLabel.adjustsFontSizeToFitWidth = true
        myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
    }
}
