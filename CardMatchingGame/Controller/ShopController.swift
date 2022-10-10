//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini
import ViewAnimator
import StoreKit

class ShopController: UIViewController, UIGestureRecognizerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver  {
    let shopInterface = ShopInterface()
    let shiny = AudioFileKey.shiny.rawValue
    let audioFX = AudioFX()
    let prop = Properties()
    let palette = Palette()
    var counter1 = 0
    var counter2 = 0
    var newArray1WithoutDuplicates: [String] = []
    var newArray2WithoutDuplicates: [String] = []
    
    private var models = [SKProduct]()
    
    override func loadView() {
        view = shopInterface.contentView
                
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
        
        SKPaymentQueue.default().add(self)
        
        loadNewSetsIntoImageButtonsForTapAnimation()
        
        DispatchQueue.main.async {
            self.updateShopUI()
        }
        
        fetchProducts()
        
        print("cardSet1isUnlocked: \(Properties.cardSet1isUnlocked)")
        print("cardSet1isSelected: \(Properties.cardSet1isSelected)")
        print("cardSet2isUnlocked: \(Properties.cardSet2isUnlocked)")
        print("cardSet2isSelected: \(Properties.cardSet2isSelected)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
            
            //payment:
            let payment = SKPayment(product: self.models[0])
            SKPaymentQueue.default().add(payment)

//            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//            let price = 0.99
//            let ac = AlertController.buyAC(confirm, cancel, price: price)
//            self.present(ac, animated: true, completion: nil)
        }
        
        
        
        if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
            //audioFX:
            let shiny = AudioFileKey.shiny.rawValue
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.cardSet1isUnlocked = true
                Properties.defaults.set(true, forKey: "cardSet1isUnlocked")
                
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            })

            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.cardSet1isSelected = true
                self.shopInterface.cardSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                //deselect another button:
                if Properties.cardSet2isUnlocked {
                    Properties.cardSet2isSelected = false
                    self.shopInterface.cardSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
            
            //payment:
            let payment = SKPayment(product: self.models[1])
            SKPaymentQueue.default().add(payment)
            
            
//            let confirm = UIAlertAction(title: "Buy", style: .default) { buy in
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//            let price = 0.99
//            let ac = AlertController.buyAC(confirm, cancel, price: price)
//            self.present(ac, animated: true, completion: nil)
        }
        
        if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.cardSet2isSelected = true
                self.shopInterface.cardSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.cardSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.cardSet2UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                //deselect another button:
                if Properties.cardSet1isUnlocked {
                    Properties.cardSet1isSelected = false
                    self.shopInterface.cardSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.cardSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.cardSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
            
            //payment:
            let payment = SKPayment(product: self.models[2])
            SKPaymentQueue.default().add(payment)
        }
        
        if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.coverSet1isSelected = true
                self.shopInterface.coverSet1UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet1UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet1UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                //deselect another button:
                if Properties.coverSet2isUnlocked {
                    Properties.coverSet2isSelected = false
                    self.shopInterface.coverSet2UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet2UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet2UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
            
            //payment:
            let payment = SKPayment(product: self.models[3])
            SKPaymentQueue.default().add(payment)

        }
        
        if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
            //animation:
            UIView.animate(withDuration: 1.0, animations: {
                Properties.coverSet2isSelected = true
                self.shopInterface.coverSet2UnlockButton.backgroundColor = .gray
                self.shopInterface.coverSet2UnlockButton.setTitle("selected", for: .normal)
                self.shopInterface.coverSet2UnlockButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                //deselect another button:
                if Properties.coverSet1isUnlocked {
                    Properties.coverSet1isSelected = false
                    self.shopInterface.coverSet1UnlockButton.setTitle("select", for: .normal)
                    self.shopInterface.coverSet1UnlockButton.backgroundColor = .green
                    self.shopInterface.coverSet1UnlockButton.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
    
    //MARK: - AppStore Purchase:

    //Products:
    enum Product: String, CaseIterable {
        case cardSet1 =     "com.vladimirkratinov.matchpair.cardSet1"
        case cardSet2 =     "com.vladimirkratinov.matchpair.cardSet2"
        case cardCover1 =   "com.vladimirkratinov.matchpair.cardCover1"
        case cardCover2 =   "com.vladimirkratinov.matchpair.cardCover2"
    }
    
    private func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            print("Shop products: \(response.products.count)")
            self.models = response.products
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //no implementation
        transactions.forEach({ transaction in
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("purchased")
                handlePurchase(transaction.payment.productIdentifier)
            case .failed:
                print("failed")
            case .restored:
                print("restored")
            case .deferred:
                print("deferred")
            default: return
            }
        })
    }
    
    private func paymentInitiation() {
        
    }
    
    private func handlePurchase(_ id: String) {
        print(id)
        
        switch id {
            
        case Product.cardSet1.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.cardSet1isUnlocked = true
            Properties.defaults.set(true, forKey: "cardSet1isUnlocked")
            
            //animation:
            unlockAnimation(button: shopInterface.cardSet1UnlockButton)
            
        case Product.cardSet2.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.cardSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "cardSet2isUnlocked")
            
            //animation:
            unlockAnimation(button: shopInterface.cardSet2UnlockButton)
            
        case Product.cardCover1.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.coverSet1isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet1isUnlocked")
            
            //animation:
            unlockAnimation(button: shopInterface.coverSet1UnlockButton)
            
            
        case Product.cardCover2.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.coverSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet2isUnlocked")
            
            //animation:
            unlockAnimation(button: shopInterface.coverSet2UnlockButton)
            
        default: return
        }
    }
    
    func unlockAnimation(button: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            button.backgroundColor = .green
            button.setTitle("select", for: .normal)
            button.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        })
    }
    
    func selectedAnimation(button: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            button.backgroundColor = .gray
            button.setTitle("selected", for: .normal)
            button.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        })
    }
    
    func selectAnimation(button: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            button.backgroundColor = .green
            button.setTitle("select", for: .normal)
            button.setImage(UIImage(systemName: "hand.point.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        })
    }
}
