//
//  GameLogic.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/20.
//

import UIKit

public class GameLogic {
    
    public func setupCards(_ set: [String]) {
    
        //if same amount card buttons and cardlist:
        if Properties.cardButtons.count == set.count {
            
            //create pair list:
            Properties.pairList = set
            
            //shuffle card list:
            let shuffledList = set.shuffled()
            
            //set title:
            for i in 0..<Properties.cardButtons.count {
                Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
            }
                
            //button names list:
            print("Properties.cardButtons Count: \(Properties.cardButtons.count)")
            print("Properties.cardList Count: \(set.count)")
            
        } else {
            //create lower amounts of card list:
            Properties.lowerAmmountOfCardsList = set
            print(Properties.lowerAmmountOfCardsList)
            
            //remove other cards, if less then 20
            let sum = set.count - Properties.cardButtons.count
//            let sum = Properties.cardButtons.count - set.count
            
            
            //BUG ??? Range requires lowerBound <= upperBound
            for _ in 0..<abs(sum) {
                if sum > 0 {
                    Properties.lowerAmmountOfCardsList.removeLast()
                }
            }
            print(Properties.lowerAmmountOfCardsList)
            
            //create pair list:
            Properties.pairList = Properties.lowerAmmountOfCardsList
            
            //shuffle card list:
            let shuffledList = Properties.lowerAmmountOfCardsList.shuffled()
            
            //set title:
            for i in 0..<Properties.cardButtons.count {
                Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
            }
            
            //button names list:
            print("Properties.cardButtons Count: \(Properties.cardButtons.count)")
            print("lowerAmmountOfCardsList Count: \(Properties.lowerAmmountOfCardsList.count)")
        }
    }
}
