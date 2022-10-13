//
//  LockerModel.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/23.
//

import UIKit
import Gemini

struct LockerModel: Codable {
    var cellNumber: Int
    var isLocked: Bool
    var unlockPrice: Int
    var isSelected: Bool
    
    //MARK: - loadLockerModel:
    
    static func loadLockerModel() {
        let defaults = UserDefaults.standard
        
        for i in 0..<Properties.listOfSets.count {
            if Properties.collectionOfLockedSets.count < Properties.listOfSets.count {
                
                //create Model:
//                let newModel = LockerModel(cellNumber: i, isLocked: true, unlockPrice: i * 100, isSelected: false)
                let newModel = LockerModel(cellNumber: i, isLocked: true, unlockPrice: Properties.unlockPriceGlobal, isSelected: false)
                Properties.collectionOfLockedSets.append(newModel)
                
                //autoFill Bool list with true - to show locked UI:
                Properties.unlockedList.append(true)
                //unlock first default set:
                Properties.collectionOfLockedSets[i].isLocked = Properties.unlockedList[i]
            }
        }
        
        let unlockedValues = defaults.object(forKey: "unlockedList") as? [Bool]

        for i in 0..<Properties.listOfSets.count {
            Properties.collectionOfLockedSets[i].isLocked = unlockedValues?[i] ?? true
            Properties.unlockedList[i] = unlockedValues?[i] ?? true
        }
        
        //unlock first cell in UI and in Bool list:
        Properties.collectionOfLockedSets[0].isLocked = false
        Properties.unlockedList[0] = false
        
        //select first set default:
        
        
        //select first set default:
        if !Properties.cardSet1isSelected || !Properties.cardSet1isSelected {
            if Properties.selectedList.isEmpty {
                Properties.collectionOfLockedSets[0].isSelected = true
            }
        } else {
            Properties.collectionOfLockedSets[0].isSelected = false
        }
        
//        if Properties.selectedList.isEmpty {
//            Properties.collectionOfLockedSets[0].isSelected = true
//        } else {
//            Properties.collectionOfLockedSets[0].isSelected = false
//        }

        print("loading Locker Model: \(Properties.collectionOfLockedSets)")
    }
    
    //MARK: - Unlock:
    
    static func unlock(cell: CollectionViewCell, price: Int, index: IndexPath.Index) {
        
        //check price first:
        if Properties.coins >= price {
            
            //reduce price from user coins:
            Properties.coins -= price
            
            print("cutted \(price) from \(Properties.coins) coins!")
            Properties.defaults.set(Properties.coins, forKey: CoinsKey.coins.rawValue)
            print("now you have \(Properties.coins) coins!")
     
            //prepare label and shadow layer before animation
            cell.myLabel.isHidden = false
//            cell.myLabel.alpha = 0
            
            cell.myShadowView.isHidden = false
            cell.myShadowView.alpha = 0.4
            
            cell.selectButton.isHidden = false
            cell.selectButton.alpha = 0
            
            //animation block:
            UIView.animate(withDuration: 1.0, animations: {
                cell.myImageView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
                cell.unlockButton.layer.transform = CATransform3DMakeTranslation(0, 80, 0)
                cell.selectButton.alpha = 1
                cell.myShadowView.alpha = 0
                cell.myImageView.alpha = 1
//                cell.myLabel.alpha = 1
                cell.lockerImageView.alpha = 0
                cell.lockerImageView.shake()
                cell.lockerImageView.rotate(angle: 45)
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //bounce back:
                UIView.animate(withDuration: 0.5) {
                    cell.myImageView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
                //hide all views that already were animated:
//                cell.myLabel.isHidden = false
                cell.lockerImageView.isHidden = true
                cell.unlockButton.isHidden = true
                cell.selectButton.isHidden = false
            }
            
            //change property in Locker Class:
            Properties.collectionOfLockedSets[index].isLocked = false
            
            //UserDefaults 2 version:
            let defaults = UserDefaults.standard
            
            Properties.unlockedList[index] = Properties.collectionOfLockedSets[index].isLocked
            defaults.set(Properties.unlockedList, forKey: "unlockedList")
        }
    }
    
    //MARK: - Select:
    
    static func select(cell: CollectionViewCell, index: IndexPath.Index) {
        Properties.selectedList.removeAll()
        
        //animation block:
        UIView.animate(withDuration: 1.0, animations: {
            cell.selectButton.backgroundColor = .gray
            cell.selectButton.setTitle("selected", for: .normal)
        })

        for i in 0..<Properties.listOfSets.count {
            Properties.collectionOfLockedSets[i].isSelected = false
            Properties.selectedList.append(false)
        }
        //unlock selected cell in UI and in Bool list:
        Properties.collectionOfLockedSets[index].isSelected = true
        Properties.selectedList[index] = Properties.collectionOfLockedSets[index].isSelected
        
        print("Selected Locker Model: \(Properties.collectionOfLockedSets)")
        print("selected list: \(Properties.selectedList)")
    }
    
//MARK: - updateUILockerButtons:
    
    static func updateUILockerButtons(cell: CollectionViewCell,index: IndexPath.Index) {
        //if locked:
        if Properties.collectionOfLockedSets[index].isLocked {
            //price:
            let price = Properties.collectionOfLockedSets[index].unlockPrice
            
            cell.lockerImageView.isHidden = false
            cell.unlockButton.setTitle("🪙 \(price)", for: .normal)
            cell.myLabel.isHidden = false
            cell.selectButton.isHidden = true
            cell.myImageView.alpha = 1
            
            //price button color & mechanics:
            if price > Properties.coins {
                    cell.unlockButton.backgroundColor = .systemRed
                    cell.unlockButton.alpha = 1
                    cell.unlockButton.isEnabled = false
            } else { // if price < Properties.coins
                    cell.unlockButton.backgroundColor = .green
                    cell.unlockButton.alpha = 1
                    cell.unlockButton.isEnabled = true
            }

        } else { //if not locked
            cell.lockerImageView.isHidden = true
            cell.unlockButton.isHidden = true
            cell.myShadowView.isHidden = true
            cell.myLabel.isHidden = false
            cell.selectButton.isHidden = false
            cell.myLabel.alpha = 1
            cell.myImageView.alpha = 1
        }
    }
    
    //MARK: - updateUISelectButtons:
        
        static func updateUISelectButtons(cell: CollectionViewCell,index: IndexPath.Index) {
            let palette = Palette()
            
            if Properties.collectionOfLockedSets[index].isSelected {
//                cell.selectButton.isEnabled = true
                cell.selectButton.backgroundColor = .gray
                cell.selectButton.setTitle("selected", for: .normal)
            } else { //if not locked
//                cell.selectButton.isEnabled = true
                cell.selectButton.backgroundColor = palette.UIGreen
            }
            
            if Properties.cardSet1isSelected || Properties.cardSet2isSelected {
                cell.selectButton.backgroundColor = .green
                cell.selectButton.setTitle("select", for: .normal)
            }
        }
}
