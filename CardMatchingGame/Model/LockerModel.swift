//
//  LockerModel.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/23.
//

import UIKit

struct LockerModel: Codable {
    var cellNumber: Int
    var isLocked: Bool
    var unlockPrice: Int
    
    //MARK: - loadLockerModel:
    
    static func loadLockerModel() {
        let defaults = UserDefaults.standard
        //First One (Working):
//        for i in 0..<Properties.listOfSets.count {
//            if Properties.collectionOfLockedSets.count < Properties.listOfSets.count {
//                let lockerModel = LockerModel(cellNumber: i, isLocked: true, unlockPrice: i * 5)
//                Properties.collectionOfLockedSets.append(lockerModel)
//            }
//        }
        
//        !!!: TEST (WORKING)
        
        for i in 0..<Properties.listOfSets.count {
            if Properties.collectionOfLockedSets.count < Properties.listOfSets.count {
                
                //create Model:
                let newModel = LockerModel(cellNumber: i, isLocked: true, unlockPrice: i * 10)
                Properties.collectionOfLockedSets.append(newModel)
                
                //autoFill Bool list with true - to show locked UI:
                Properties.unlockedList.append(true)
                //unlock first default set:
                Properties.collectionOfLockedSets[i].isLocked = Properties.unlockedList[i]
            }
        }
        

        let values = defaults.object(forKey: "unlockedList") as? [Bool]
        
//        Properties.collectionOfLockedSets[0].isLocked = values?[0] ?? true
//        Properties.collectionOfLockedSets[1].isLocked = values?[1] ?? true
//        Properties.collectionOfLockedSets[2].isLocked = values?[2] ?? true
//        Properties.collectionOfLockedSets[3].isLocked = values?[3] ?? true
//        Properties.collectionOfLockedSets[4].isLocked = values?[4] ?? true
//        Properties.collectionOfLockedSets[5].isLocked = values?[5] ?? true
//
//        Properties.unlockedList[0] = values?[0] ?? true
//        Properties.unlockedList[1] = values?[1] ?? true
//        Properties.unlockedList[2] = values?[2] ?? true
//        Properties.unlockedList[3] = values?[3] ?? true
//        Properties.unlockedList[4] = values?[4] ?? true
//        Properties.unlockedList[5] = values?[5] ?? true
        
        for i in 0..<Properties.listOfSets.count {
            Properties.collectionOfLockedSets[i].isLocked = values?[i] ?? true
            Properties.unlockedList[i] = values?[i] ?? true
        }
        
        //unlock first cell in UI and in Bool list:
        Properties.collectionOfLockedSets[0].isLocked = false
        Properties.unlockedList[0] = false
    }
}
