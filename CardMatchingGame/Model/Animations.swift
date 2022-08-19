//
//  Animations.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/12.
//

import UIKit



class Animations: UIViewController {
    func spring(_ sender: UILabel) {
        sender.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
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
