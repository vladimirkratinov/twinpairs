//
//  GameLogic.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/20.
//

import UIKit

public class GameLogic {
    
    public func setupCards(_ set: [String]) {
        Properties.pairList = set
        print("SETUP CARDBUTTONS: \(Properties.cardButtons.count)")
        
        if Properties.pairList.count > Properties.cardButtons.count {
            let howManyCardsToDelete = Properties.pairList.count - Properties.cardButtons.count
            howManyCardsToDelete.times {
                Properties.pairList.removeLast()
            }
            shuffleAndSetTitle()
        } else {
            shuffleAndSetTitle()
        }
        print("LOADED LIST OF CARDS COUNT: \(Properties.pairList.count)")
    }
    
    private func shuffleAndSetTitle() {
        let shuffledList = Properties.pairList.shuffled()
        for i in 0..<Properties.cardButtons.count {
            //delete suffix and prefix:
//            var cleanString = ""
//            var clearedShuffledList = [String]()
//            
//            for item in shuffledList {
//                let cleanName = item
//                    .deletingSuffix(".png")
//                    .deletingPrefix("set")
//                let dropNumber = cleanName.dropFirst()
//                let dropLine = dropNumber.dropFirst()
//                let replaceLinesWithSpaces = dropLine.replacingOccurrences(of: "_", with: " ")
//                cleanString = replaceLinesWithSpaces
//                clearedShuffledList.append(cleanString)
//            }
            
            Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
        }
    }
}
