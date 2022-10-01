//
//  AlertController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/26.
//

import UIKit

class AlertController {
    
    static func presentAC(_ action1: UIAlertAction, _ action2: UIAlertAction, price: Int) -> UIAlertController {
        //attributed AlertController:
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: FontKey.staatliches.rawValue, size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ]
        
        let titleString = NSAttributedString(string: "Unlock", attributes: titleAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let messageText = NSAttributedString(
            string: "Open this card set for \(price) coins?",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor : UIColor.red,
                NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 14)!,
            ]
        )
        let ac = UIAlertController(title: "", message: "", preferredStyle: .alert)
        ac.setValue(titleString, forKey: "attributedTitle")
        ac.setValue(messageText, forKey: "attributedMessage")
        
        ac.addAction(action1)
        ac.addAction(action2)
        
        return ac
    }
    
    static func buyAC(_ action1: UIAlertAction, _ action2: UIAlertAction, price: Double) -> UIAlertController {
        //attributed AlertController:
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: FontKey.staatliches.rawValue, size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ]
        
        let titleString = NSAttributedString(string: "purchase", attributes: titleAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let messageText = NSAttributedString(
            string: "Buy it for $\(price)?",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor : UIColor.red,
                NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 14)!,
            ]
        )
        let ac = UIAlertController(title: "", message: "", preferredStyle: .alert)
        ac.setValue(titleString, forKey: "attributedTitle")
        ac.setValue(messageText, forKey: "attributedMessage")
        
        ac.addAction(action1)
        ac.addAction(action2)
        
        return ac
    }
    
    static func informationAC() -> UIAlertController {
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ]
        
          let titleString = NSAttributedString(string: "Information", attributes: titleAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let messageText = NSAttributedString(
            string: Properties.infoMessage,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 13)!,
            ]
        )
        
        let ac = UIAlertController(title: "", message: "", preferredStyle: .alert)
        ac.setValue(titleString, forKey: "attributedTitle")
        ac.setValue(messageText, forKey: "attributedMessage")
        
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        ac.addAction(cancel)
        
        return ac
    }
    
}
