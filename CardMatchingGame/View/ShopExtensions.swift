//
//  ShopUpdate.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022-10-10.
//

import UIKit

extension ShopController {
    
    func selectAnimation(button: UIButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                button.backgroundColor = .green
                button.setTitle("select", for: .normal)
                button.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            })
        }
    }
    
    func selectedAnimation(button: UIButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                button.backgroundColor = .gray
                button.setTitle("selected", for: .normal)
                button.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
            })
        }
    }
        
    func hardcodedSelectedList(_ number: Int) {
        //hardcoded selected list (set7 = [6])
        Properties.selectedSetName = Properties.listOfSets[number]
        Properties.selectedCollection = Properties.cardCollection[number]
        print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
        
        if let safeString = Properties.selectedCollection.first {
            Properties.selectedCardList = safeString
            Properties.selectedCardListNumber = number
            print("Selected CardList: \(Properties.selectedCardList)")
            print(Properties.selectedCardListNumber)
        }
    }
    
    func updateShopUI() {
        
            //update set1:
            if !Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("unlock", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = self.palette.shopUnlockButtonOrange
            }
            
            if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            //deselect another button:
            if Properties.cardSet1isUnlocked && Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
                    self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
            
            //update set2:
            if !Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
                self.shopInterface.cardSet2UnlockButton.setTitle("unlock", for: .normal)
                self.shopInterface.cardSet2UnlockButton.backgroundColor = self.palette.shopUnlockButtonOrange
            }
            
            if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
                self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
                self.shopInterface.cardSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            //deselect another button:
            if Properties.cardSet2isUnlocked && Properties.cardSet2isSelected {
                self.shopInterface.cardSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet2UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                    self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
            
            //update cover set1:
            if !Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
                self.shopInterface.coverSet1UnlockButton.setTitle("unlock", for: .normal)
                self.shopInterface.coverSet1UnlockButton.backgroundColor = self.palette.shopUnlockButtonOrange
            }
            
            if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
                self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                self.shopInterface.coverSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            //deselect another button:
            if Properties.coverSet1isUnlocked && Properties.coverSet1isSelected {
                self.shopInterface.coverSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet1UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
                    self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
            
            //update cover set2:
            if !Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
                self.shopInterface.coverSet2UnlockButton.setTitle("unlock", for: .normal)
                self.shopInterface.coverSet2UnlockButton.backgroundColor = self.palette.shopUnlockButtonOrange
            }
            
            if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
                self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
                self.shopInterface.coverSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            //deselect another button:
            if Properties.coverSet2isUnlocked && Properties.coverSet2isSelected {
                self.shopInterface.coverSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet2UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
                    self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
        
    }
}
