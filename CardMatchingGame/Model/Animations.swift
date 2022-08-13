//
//  Animations.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/12.
//

import UIKit

struct Animations {
    
    func spring(_ sender: UILabel) {
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.3),
                       initialSpringVelocity: CGFloat(0.3),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}
