//
//  DetailInterface.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit

class DetailInterface: UIView {
    
    var detailView: UIView = {
        let detailView = UIView()
        return detailView
    }()
    
    var backgroundView: UIView = {
        let backgroundView = UIView()
        return backgroundView
    }()
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.alpha = 1
        imageView.image = UIImage(named: FigmaKey.backgroundCardList2.rawValue)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var detailUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.alpha = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        return view
    }()
    
    var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "LaunchScreen1")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.contentMode = .redraw
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        return imageView
    }()
    
    var detailImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .redraw
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "History"
        label.font = UIFont(name: FontKey.FuturaExtraBold.rawValue, size: 20)
        label.isHidden = true
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "description label"
        label.isHidden = true
        label.font = UIFont(name: FontKey.staatliches.rawValue, size: 20)
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.text = "A postage stamp is a small piece of paper issued by a post office, postal administration, or other authorized vendors to customers who pay postage (the cost involved in moving, insuring, or registering mail), who then affix the stamp to the face or address-side of any item of mail—an envelope or other postal cover (e.g., packet, box, mailing cylinder)—that they wish to send. \n \n The item is then processed by the postal system, where a postmark or cancellation mark—in modern usage indicating date and point of origin of mailing—is applied to the stamp and its left and right sides to prevent its reuse. \n \n The item is then delivered to its addressee."
        label.font = UIFont(name: "AmericanTypewriter", size: 15)
        label.numberOfLines = 20
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    func setupSubviews() {
        detailView.addSubview(backgroundView)
        detailView.addSubview(detailUIView)
        detailView.addSubview(descriptionLabel)
        backgroundView.addSubview(backgroundImageView)
        detailUIView.addSubview(detailImageButton)
        detailUIView.addSubview(titleLabel)
        detailUIView.addSubview(detailLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: detailView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: detailUIView.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            
            detailUIView.leadingAnchor.constraint(equalTo: detailView.layoutMarginsGuide.leadingAnchor),
            detailUIView.trailingAnchor.constraint(equalTo: detailView.layoutMarginsGuide.trailingAnchor),
            detailUIView.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            
            detailImageButton.topAnchor.constraint(equalTo: detailUIView.topAnchor, constant: 10),
            detailImageButton.leadingAnchor.constraint(equalTo: detailUIView.leadingAnchor, constant: 10),
            detailImageButton.trailingAnchor.constraint(equalTo: detailUIView.trailingAnchor, constant: -10),
            detailImageButton.bottomAnchor.constraint(equalTo: detailUIView.bottomAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: detailUIView.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: detailUIView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: detailUIView.leadingAnchor, constant: 75),
            detailLabel.trailingAnchor.constraint(equalTo: detailUIView.trailingAnchor, constant: -75),
            detailLabel.bottomAnchor.constraint(equalTo: detailUIView.bottomAnchor, constant: -75),
            ])
    }
}
