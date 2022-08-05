////
////  CardButton.swift
////  CardMatchingGame
////
////  Created by Vladimir Kratinov on 2022/7/29.
////
//
//import UIKit
//
//class CardButton {
//    
//    func setup2Card() {
//        let UI = UserInterface()
//        cardButtons.append(UI.cardButton)
//        print("CardButtons List: \(cardButtons)")
//    }
//    
//    func setup1Card() {
//        let UI = UserInterface()
//        
//        UI.cardButton.frame = CGRect(x: 0, y: 0, width: 100, height: 140)
//        UI.buttonsView.addSubview(UI.cardButton)
//        cardButtons.append(UI.cardButton)
//    }
//    
//    func setup(rows: Int, columns: Int, width: Int, height: Int) {
//        let UI = UserInterface()
//        
//        for row in 0..<rows {
//            for column in 0..<columns {
//                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
//                UI.cardButton.frame = frame
//                
//                UI.buttonsView.addSubview(UI.cardButton)
//                cardButtons.append(UI.cardButton)
////                if cardButtons.isEmpty == false {
////                    print("cardButtons List appending counting...")
////                }
//            }
//        }
//    }
//}
