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
    var counter1 = 0
    var counter2 = 0
    var newArray1WithoutDuplicates: [String] = []
    var newArray2WithoutDuplicates: [String] = []
    
    override func loadView() {
//        view = shopInterface.shopView
        view = shopInterface.contentView
//        view.insertSubview(shopInterface.backgroundImageView, at: 0)
                
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setup UIScrollView scroll effect:
//        self.shopInterface.scrollView.contentSize = CGSize(width:shopInterface.contentView.bounds.width, height: shopInterface.contentView.bounds.height - 80)
//        self.shopInterface.scrollView.contentSize = CGSize(width:shopInterface.contentView.frame.width, height: shopInterface.contentView.frame.height + 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        loadNewSetsIntoImageButtonsForTapAnimation()
        
        
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
        
        print("cardSet1isUnlocked: \(Properties.cardSet1isUnlocked)")
        print("cardSet1isSelected: \(Properties.cardSet1isSelected)")
        print("cardSet2isUnlocked: \(Properties.cardSet2isUnlocked)")
        print("cardSet2isSelected: \(Properties.cardSet2isSelected)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - cardSet Image Buttons:
    
    @objc func cardSet1ImageButtonTapped(_ sender: UIButton) {
        //new code with scroll card list animation:
        UIView.transition(with: sender,
                          duration:
                            prop.flipAnimationTime,
                          options: .transitionFlipFromRight,
                          animations: nil,
                          completion: nil)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if counter1 == 0 {
            let imageName = newArray1WithoutDuplicates[counter1]
            sender.setImage(UIImage(named: imageName), for: .normal)
            counter1 += 1
        }

        if counter1 < newArray1WithoutDuplicates.count {
            let imageName = newArray1WithoutDuplicates[counter1]
            sender.setImage(UIImage(named: imageName), for: .normal)
            counter1 += 1
            
        } else {
            counter1 = 0
            let imageName = newArray1WithoutDuplicates[counter1]
            sender.setImage(UIImage(named: imageName), for: .normal)
        }
        
//        print(counter1)

        //old code with back side with description:
        
        
//        if sender.imageView?.image != UIImage(named: "set7_canada02") {
//            //flip animation:
//            UIView.transition(with: sender,
//                              duration: prop.flipAnimationTime,
//                              options: .transitionFlipFromLeft,
//                              animations: nil,
//                              completion: nil)
//
//            sender.setImage(UIImage(named: "set7_canada02"), for: .normal)
//
//            //audioFX:
//            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
//
//            //animation:
//            UIView.animate(withDuration: 0.2, animations: {
//                self.shopInterface.cardSet1DescriptionLabel.alpha = 0
//            })
//
//        } else {
//            //flip animation:
//            UIView.transition(with: sender,
//                              duration: prop.flipAnimationTime,
//                              options: .transitionFlipFromRight,
//                              animations: nil,
//                              completion: nil)
//
//            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
//
//            //audioFX
//            audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
//
//            //animation:
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.shopInterface.cardSet1DescriptionLabel.alpha = 1
//                })
//            }
//        }
    }
    
    @objc func cardSet2ImageButtonTapped(_ sender: UIButton) {
        //new code with scroll card list animation:
        UIView.transition(with: sender,
                          duration:
                            prop.flipAnimationTime,
                          options: .transitionFlipFromRight,
                          animations: nil,
                          completion: nil)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if counter2 == 0 {
            let imageName = newArray2WithoutDuplicates[counter2]
            sender.setImage(UIImage(named: imageName), for: .normal)
            counter2 += 1
        }

        if counter2 < newArray2WithoutDuplicates.count {
            let imageName = newArray2WithoutDuplicates[counter2]
            sender.setImage(UIImage(named: imageName), for: .normal)
            counter2 += 1
            
        } else {
            counter2 = 0
            let imageName = newArray2WithoutDuplicates[counter2]
            sender.setImage(UIImage(named: imageName), for: .normal)
        }
        
//        print(counter2)

        //old code with back side with description:
        
//        //flip animation:
//        if sender.imageView?.image != UIImage(named: "set8_ukraine01") {
//            UIView.transition(with: sender,
//                              duration: prop.flipAnimationTime,
//                              options: .transitionFlipFromLeft,
//                              animations: nil,
//                              completion: nil)
//
//            sender.setImage(UIImage(named: "set8_ukraine01"), for: .normal)
//
//            //audioFX:
//            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
//
//            //animation:
//            UIView.animate(withDuration: 0.2, animations: {
//                self.shopInterface.cardSet2DescriptionLabel.alpha = 0
//            })
//
//        } else {
//            //flip animation:
//            UIView.transition(with: sender,
//                              duration: prop.flipAnimationTime,
//                              options: .transitionFlipFromRight,
//                              animations: nil,
//                              completion: nil)
//
//            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
//
//            //audioFX
//            audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
//
//            //animation:
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.shopInterface.cardSet2DescriptionLabel.alpha = 1
//                })
//            }
//        }
    }
    
    //MARK: - Cover Image Buttons:
    
    @objc func coverSet1ImageButtonTapped(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            //flip animation:
            UIView.transition(with: sender,
                              duration:
                                prop.flipAnimationTime,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)

            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)

            //audioFX:
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)

        } else {
            //flip animation:
            UIView.transition(with: sender,
                              duration: prop.flipAnimationTime,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)

            sender.setImage(UIImage(named: "shop_cover_1"), for: .normal)

            //audioFX:
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
        }
        
    }
    
    @objc func coverSet2ImageButtonTapped(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            //flip animation:
            UIView.transition(with: sender,
                              duration: prop.flipAnimationTime,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
            
            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)
            
            //audioFX:
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
            
        } else {
            //flip animation:
            UIView.transition(with: sender,
                              duration: prop.flipAnimationTime,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)
            
            sender.setImage(UIImage(named: "shop_cover_2"), for: .normal)
            
            //audioFX:
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
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
            
            //hardcoded selected list (set7 = [6])
            Properties.selectedSetName = Properties.listOfSets[6]
            Properties.selectedCollection = Properties.cardCollection[6]
            print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
            
            if let safeString = Properties.selectedCollection.first {
                Properties.selectedCardList = safeString
                Properties.selectedCardListNumber = 6
                print("Selected CardList: \(Properties.selectedCardList)")
                print(Properties.selectedCardListNumber)
            }
        }
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
            
            //hardcoded selected list (set8 = [7])
            Properties.selectedSetName = Properties.listOfSets[7]
            Properties.selectedCollection = Properties.cardCollection[7]
            print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
            
            if let safeString = Properties.selectedCollection.first {
                Properties.selectedCardList = safeString
                Properties.selectedCardListNumber = 7
                print("Selected CardList: \(Properties.selectedCardList)")
                print(Properties.selectedCardListNumber)
            }
        }
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
    }
    
    func loadNewSetsIntoImageButtonsForTapAnimation() {
        //creating set to avoid duplicates:
        let copySet1WithoutDuplicates = Set(Properties.cardCollection[6])
        let copySet2WithoutDuplicates = Set(Properties.cardCollection[7])
        let sortedSet1 = copySet1WithoutDuplicates.sorted()
        let sortedSet2 = copySet2WithoutDuplicates.sorted()
        for element in sortedSet1 {
            newArray1WithoutDuplicates.append(element)
        }
        
        for element in sortedSet2 {
            newArray2WithoutDuplicates.append(element)
        }
        
        print(newArray1WithoutDuplicates)
        print(newArray2WithoutDuplicates)
    }
}
