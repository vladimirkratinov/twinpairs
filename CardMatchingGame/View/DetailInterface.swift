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
    
    var backgroundImageView1: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "LaunchScreen1")
        backgroundImageView.contentMode = .top
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var backgroundImageView2: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "LaunchScreen1")
        backgroundImageView.contentMode = .bottom
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var detailImageView: UIImageView = {
        let detailImageView = UIImageView()
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.image = UIImage(named: "LaunchScreen1")
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.clipsToBounds = true
        return detailImageView
    }()
    
    func setupSubviews() {
        
        detailView.addSubview(backgroundView)
        backgroundView.addSubview(backgroundImageView1)
        backgroundView.addSubview(backgroundImageView2)
        detailView.addSubview(detailImageView)
//        detailView.insertSubview(backgroundImageView1, at: 0)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView1.topAnchor.constraint(equalTo: detailView.topAnchor),
            backgroundImageView1.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            backgroundImageView1.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            backgroundImageView1.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            
            backgroundImageView2.topAnchor.constraint(equalTo: detailView.topAnchor),
            backgroundImageView2.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            backgroundImageView2.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            backgroundImageView2.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            
            detailImageView.topAnchor.constraint(equalTo: detailView.topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            detailImageView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            ])
    }
}
