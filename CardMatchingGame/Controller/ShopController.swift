//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini
import ViewAnimator

class ShopController: UIViewController, UIGestureRecognizerDelegate {
    
    let shopInterface = ShopInterface()
    let audioFX = AudioFX()
    let prop = Properties()
    let palette = Palette()
    
    override func loadView() {
        view = shopInterface.shopView
        view.insertSubview(shopInterface.backgroundImageView, at: 0)
                
        shopInterface.setupSubviews()
        shopInterface.setupConstraints()
        
        shopInterface.cardSet1ImageButton.addTarget(self, action: #selector(cardSet1ImageButtonTapped), for: .touchUpInside)
        shopInterface.cardSet2ImageButton.addTarget(self, action: #selector(cardSet2ImageButtonTapped), for: .touchUpInside)
        shopInterface.coverSet1ImageButton.addTarget(self, action: #selector(coverSet1ImageButtonTapped), for: .touchUpInside)
        shopInterface.coverSet2ImageButton.addTarget(self, action: #selector(coverSet2ImageButtonTapped), for: .touchUpInside)

        shopInterface.cardSet1UnlockButton.addTarget(self, action: #selector(cardSet1UnlockButtonTapped), for: .touchUpInside)
        shopInterface.cardSet2UnlockButton.addTarget(self, action: #selector(cardSet2UnlockButtonTapped), for: .touchUpInside)
        shopInterface.coverSet1UnlockButton.addTarget(self, action: #selector(coverSet1UnlockButtonTapped), for: .touchUpInside)
        shopInterface.coverSet2UnlockButton.addTarget(self, action: #selector(coverSet2UnlockButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        DispatchQueue.main.async {
            
            //update set1:
            
            if !Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("unlock", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = self.palette.shopUnlockButtonOrange
            }
            
            if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
            }
            
            //deselect another button:
            
            if Properties.cardSet1isUnlocked && Properties.cardSet1isSelected {
                self.shopInterface.cardSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .gray
                
                if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
                    self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
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
            }
            //deselect another button:
            
            if Properties.cardSet2isUnlocked && Properties.cardSet2isSelected {
                self.shopInterface.cardSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet2UnlockButton.backgroundColor = .gray
                
                if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
                    self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
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
            }
            
            //deselect another button:
            if Properties.coverSet1isUnlocked && Properties.coverSet1isSelected {
                self.shopInterface.coverSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet1UnlockButton.backgroundColor = .gray
                
                if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
                    self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
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
            }
            //deselect another button:
            if Properties.coverSet2isUnlocked && Properties.coverSet2isSelected {
                self.shopInterface.coverSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet2UnlockButton.backgroundColor = .gray
                
                if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
                    self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                }
            }
        }
        
        print()
        print("cardSet1isUnlocked: \(Properties.cardSet1isUnlocked)")
        print("cardSet1isSelected: \(Properties.cardSet1isSelected)")
        print()
        print("cardSet2isUnlocked: \(Properties.cardSet2isUnlocked)")
        print("cardSet2isSelected: \(Properties.cardSet2isSelected)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
    }
    
    //MARK: - cardSet Image Buttons:
    
    @objc func cardSet1ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: "set6_Stamp1") {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "set6_Stamp1"), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
        }
    }
    
    @objc func cardSet2ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: "set5_Stamp1") {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "set5_Stamp1"), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
        }
    }
    
    //MARK: - Cover Image Buttons:
    
    @objc func coverSet1ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "shop_cover_1"), for: .normal)
        }
        
    }
    
    @objc func coverSet2ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "shop_cover_2"), for: .normal)
        }
    }
    
    //MARK: - cardSet1 Unlock:
    
    @objc func cardSet1UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)

        if !Properties.cardSet1isUnlocked {
            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
                //animation:
                UIView.animate(withDuration: 1.0, animations: {
                    Properties.cardSet1isUnlocked = true
                    Properties.defaults.set(true, forKey: "cardSet1isUnlocked")
                    
                    self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                })
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let price = 0.99
            let ac = AlertController.buyAC(confirm, cancel, price: price)
            self.present(ac, animated: true, completion: nil)
        }
        
        if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.cardSet1isSelected = true
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet1UnlockButton.setTitle("selected", for: .normal)
                
                //deselect another button:
                if Properties.cardSet2isUnlocked {
                    Properties.cardSet2isSelected = false
                    self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
                }
            })
            
            Properties.selectedSetName = Properties.listOfSets[5]
            Properties.selectedCollection = Properties.cardCollection[5]
            print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
            
            if let safeString = Properties.selectedCollection.first {
                Properties.selectedCardList = safeString
                Properties.selectedCardListNumber = 5
                print("Selected CardList: \(Properties.selectedCardList)")
                print(Properties.selectedCardListNumber)
            }
        }
        
        print("cardSet1isUnlocked: \(Properties.cardSet1isUnlocked)")
        print("cardSet1isSelected: \(Properties.cardSet1isSelected)")
    }
    
    //MARK: - cardSet2 Unlock:
    
    @objc func cardSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if !Properties.cardSet2isUnlocked {
            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
                //animation:
                UIView.animate(withDuration: 1.0, animations: {
                    Properties.cardSet2isUnlocked = true
                    Properties.defaults.set(true, forKey: "cardSet2isUnlocked")
                    
                    self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                })
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let price = 0.99
            let ac = AlertController.buyAC(confirm, cancel, price: price)
            self.present(ac, animated: true, completion: nil)
        }
        
        if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.cardSet2isSelected = true
                self.shopInterface.cardSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet2UnlockButton.setTitle("selected", for: .normal)
                
                //deselect another button:
                if Properties.cardSet1isUnlocked {
                    Properties.cardSet1isSelected = false
                    self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                }
            })
            
            Properties.selectedSetName = Properties.listOfSets[4]
            Properties.selectedCollection = Properties.cardCollection[4]
            print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
            
            if let safeString = Properties.selectedCollection.first {
                Properties.selectedCardList = safeString
                Properties.selectedCardListNumber = 4
                print("Selected CardList: \(Properties.selectedCardList)")
                print(Properties.selectedCardListNumber)
            }
        }
        
        print("cardSet2isUnlocked: \(Properties.cardSet2isUnlocked)")
        print("cardSet2isSelected: \(Properties.cardSet2isSelected)")
    }
    
    //MARK: - coverSet1 Unlcok:
    
    @objc func coverSet1UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //alertController:
        if !Properties.coverSet1isUnlocked {
            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
                //animation:
                UIView.animate(withDuration: 1.0, animations: {
                    Properties.coverSet1isUnlocked = true
                    Properties.defaults.set(true, forKey: "coverSet1isUnlocked")
                    
                    self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                })
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let price = 0.99
            let ac = AlertController.buyAC(confirm, cancel, price: price)
            self.present(ac, animated: true, completion: nil)
        }
        
        if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.coverSet1isSelected = true
                self.shopInterface.coverSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet1UnlockButton.setTitle("selected", for: .normal)
                
                //deselect another button:
                if Properties.coverSet2isUnlocked {
                    Properties.coverSet2isSelected = false
                    self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
                }
            })
            
            // change cover image
            Properties.cardCoverImage = UIImage(named: FigmaKey.shop_cover_1.rawValue)
        }
        
        print("coverSet1isUnlocked: \(Properties.coverSet1isUnlocked)")
        print("coverSet1isSelected: \(Properties.coverSet1isSelected)")
    }
    
    //MARK: - coverSet2 Unlock:
    
    @objc func coverSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if !Properties.coverSet2isUnlocked {
            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
                //animation:
                UIView.animate(withDuration: 1.0, animations: {
                    Properties.coverSet2isUnlocked = true
                    Properties.defaults.set(true, forKey: "coverSet2isUnlocked")
                    
                    self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                })
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let price = 0.99
            let ac = AlertController.buyAC(confirm, cancel, price: price)
            self.present(ac, animated: true, completion: nil)
        }
        
        if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.coverSet2isSelected = true
                self.shopInterface.coverSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet2UnlockButton.setTitle("selected", for: .normal)
                
                //deselect another button:
                if Properties.coverSet1isUnlocked {
                    Properties.coverSet1isSelected = false
                    self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                }
            })
            
            //change cover image
            Properties.cardCoverImage = UIImage(named: FigmaKey.shop_cover_2.rawValue)
        }
        
        print("coverSet2isUnlocked: \(Properties.coverSet2isUnlocked)")
        print("coverSet2isSelected: \(Properties.coverSet2isSelected)")
    }
    
}
