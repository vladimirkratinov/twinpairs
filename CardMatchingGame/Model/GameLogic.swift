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
            Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
        }
    }
    
    public func setupSelectedSet() {
        if Properties.selectedCardList.hasPrefix("set1") {
            setupCards(Properties.cardList1)
        } else if
            Properties.selectedCardList.hasPrefix("set2") {
            setupCards(Properties.cardList2)
        } else if
            Properties.selectedCardList.hasPrefix("set3") {
            setupCards(Properties.cardList3)
        } else if
            Properties.selectedCardList.hasPrefix("set4") {
            setupCards(Properties.cardList4)
        } else if
            Properties.selectedCardList.hasPrefix("set5") {
            setupCards(Properties.cardList5)
        } else if
            Properties.selectedCardList.hasPrefix("set6") {
            setupCards(Properties.cardList6)
        }
        else {
            setupCards(Properties.cardList1)
        }
    }
}
