//
//  GameLogic.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/20.
//

import UIKit

public class GameLogic {
    var filteredListOfIndexes = [Int]()
    var filteredSelectedArray = [Int]()
    var listOfIndexes = [[Int]]()
    var selectedIndexes = [[Int]]()
    
    //MARK: - Setup Cards:
    
    public func setupCards(set: [String]) {
        Properties.pairList = set
        
        print("SETUP CARDBUTTONS: \(Properties.cardButtons.count)")
        
        if Properties.pairList.count > Properties.cardButtons.count {
            let howManyCardsToDelete = Properties.pairList.count - Properties.cardButtons.count
            //OLD CODE: WORKING, BUT NO RANDOM
            //            howManyCardsToDelete.times {
            //                Properties.pairList.removeLast()
            //            }
            
            print("howManyCardsToDelete: \(howManyCardsToDelete)")
            
            //3 pairs:
            if howManyCardsToDelete == 14 {
                
                let randomNumber1 = Int.random(in: 0...3)
                let randomNumber2 = Int.random(in: 4...6)
                let randomNumber3 = Int.random(in: 7...9)
                let randomElements = (0...9).randomElements(3).filter( {$0 != $0 } )
                
                let sortedRandomElements = randomElements.sorted()
                print("NEW RANDOMIZED ELEMENTS: \(sortedRandomElements)")
                
                
                listOfIndexes = [[0,1], [2,3], [4,5], [6,7], [8,9], [10,11], [12,13], [14,15], [16,17], [18,19]]
                selectedIndexes = [listOfIndexes[randomNumber1],
                                   listOfIndexes[randomNumber2],
                                   listOfIndexes[randomNumber3]
                ]
                
                //convert [[Int]] to [Int]
                for pair in listOfIndexes {
                    for i in pair {
                        filteredListOfIndexes.append(i)
                    }
                }
                
                //convert [[Int]] to [Int]
                for pair in selectedIndexes {
                    for i in pair {
                        filteredSelectedArray.append(i)
                    }
                }
                
                //delete selected indexes from our general list of indexes
                filteredListOfIndexes = filteredListOfIndexes.filter {!filteredSelectedArray.contains($0)}
                
                //removing randomized indexes from pairList:
                let arrayRemainingCards = Properties.pairList
                    .enumerated()
                    .filter { !filteredListOfIndexes.contains($0.offset) }
                    .map { $0.element }
                
                print("Remaining Cards after randomization: \(arrayRemainingCards)")
//                Properties.pairList.removeAll()
                Properties.pairList = arrayRemainingCards
                
                shuffleAndSetTitle()
                
                //6 pairs:
            } else if howManyCardsToDelete == 8 {
                
                let randomNumber1 = Int.random(in: 0...1)
                let randomNumber2 = Int.random(in: 2...3)
                let randomNumber3 = Int.random(in: 4...5)
                let randomNumber4 = Int.random(in: 6...7)
                var randomNumber5 = Int()
                var randomNumber6 = Int()
                
                if randomNumber1 == 1 {
                    randomNumber5 = 0
                } else {
                    randomNumber5 = 8
                }
                
                if randomNumber2 == 2 {
                    randomNumber6 = 3
                } else {
                    randomNumber6 = 9
                }

                listOfIndexes = [[0,1], [2,3], [4,5], [6,7], [8,9], [10,11], [12,13], [14,15], [16,17], [18,19]]
                selectedIndexes = [listOfIndexes[randomNumber1],
                                   listOfIndexes[randomNumber2],
                                   listOfIndexes[randomNumber3],
                                   listOfIndexes[randomNumber4],
                                   listOfIndexes[randomNumber5],
                                   listOfIndexes[randomNumber6],
                ]
                                
                //convert [[Int]] to [Int]
                for pair in listOfIndexes {
                    for i in pair {
                        filteredListOfIndexes.append(i)
                    }
                }
                
                //convert [[Int]] to [Int]
                for pair in selectedIndexes {
                    for i in pair {
                        filteredSelectedArray.append(i)
                    }
                }
                
                //delete selected indexes from our general list of indexes
                filteredListOfIndexes = filteredListOfIndexes.filter {!filteredSelectedArray.contains($0)}
                
                //removing randomized indexes from pairList:
                let arrayRemainingCards = Properties.pairList
                    .enumerated()
                    .filter { !filteredListOfIndexes.contains($0.offset) }
                    .map { $0.element }
                
                print("Remaining Cards after randomization: \(arrayRemainingCards)")
                Properties.pairList = arrayRemainingCards
                
                shuffleAndSetTitle()
            }
            print("LOADED LIST OF CARDS COUNT: \(Properties.pairList.count)")
            print("filtered selected array: \(filteredSelectedArray)")
            print("filtered list of indexes: \(filteredListOfIndexes)")
            
            //clean all randomization and sorting lists to AVOID adding in these lists after next round!!!
            listOfIndexes.removeAll()
            selectedIndexes.removeAll()
            filteredSelectedArray.removeAll()
            filteredListOfIndexes.removeAll()
            
        }
            //10 pairs:
            else {
            shuffleAndSetTitle()
        }
    }
    
    //MARK: - shuffleAndSetTitle:
    
    private func shuffleAndSetTitle() {
        let shuffledList = Properties.pairList.shuffled()
        for i in 0..<Properties.cardButtons.count {            
            Properties.cardButtons[i].setTitle(shuffledList[i], for: .normal)
        }
    }
    
    //MARK: - setupSelectedSet -> VC :
    
    public func setupSelectedSet(prefix: Int) {
        setupCards(set: Properties.cardCollection[prefix])
        }
}
