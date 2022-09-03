//
//  GameLogic.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/20.
//

import UIKit

public class GameLogic {
    
    public func setupCards(set: [String]) {
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
            Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
        }
    }
    
    public func setupSelectedSet(prefix: Int) {
        setupCards(set: Properties.cardCollection[prefix])
        print("SETUP SELECTED SET: \(Properties.cardCollection[prefix])")
        }
}
