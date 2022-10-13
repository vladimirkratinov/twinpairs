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
        
        //observer:
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

            sender.setImage(UIImage(named: FigmaKey.shop_cover_1.rawValue), for: .normal)

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
            
            sender.setImage(UIImage(named: FigmaKey.shop_cover_2.rawValue), for: .normal)
            
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
        
        //payment:
        if !Properties.cardSet1isUnlocked {
            paymentInitiation(setNumber: 0)
        }
        
        //select
        if Properties.cardSet1isUnlocked && !Properties.cardSet1isSelected {
            Properties.cardSet1isSelected = true
            selectedAnimation(button: shopInterface.cardSet1UnlockButton)
            
            //deselect another button:
            if Properties.cardSet2isUnlocked {
                Properties.cardSet2isSelected = false
                selectAnimation(button: shopInterface.cardSet2UnlockButton)
            }
            
            //select list:
            hardcodedSelectedList(6)
        }
    }
    
    //MARK: - cardSet2 Unlock:
    
    @objc func cardSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //payment:
        if !Properties.cardSet2isUnlocked {
            paymentInitiation(setNumber: 1)
        }
        
        //select
        if Properties.cardSet2isUnlocked && !Properties.cardSet2isSelected {
            Properties.cardSet2isSelected = true
            selectedAnimation(button: shopInterface.cardSet2UnlockButton)
            
            //deselect another button:
            if Properties.cardSet1isUnlocked {
                Properties.cardSet1isSelected = false
                selectAnimation(button: shopInterface.cardSet1UnlockButton)
            }
            
            //select list:
            hardcodedSelectedList(7)
        }
    }
    
    //MARK: - coverSet1 Unlcok:
    
    @objc func coverSet1UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //payment:
        if !Properties.coverSet1isUnlocked {
            paymentInitiation(setNumber: 2)
        }
        
        //select:
        if Properties.coverSet1isUnlocked && !Properties.coverSet1isSelected {
            Properties.coverSet1isSelected = true
            selectedAnimation(button: shopInterface.coverSet1UnlockButton)
            
            //deselect another button:
            if Properties.coverSet2isUnlocked {
                Properties.coverSet2isSelected = false
                selectAnimation(button: shopInterface.coverSet2UnlockButton)
            }
            
            //set cover card set in game:
            Properties.cardCoverImage = UIImage(named: FigmaKey.shop_cover_1.rawValue)
        }
    }
    
    //MARK: - coverSet2 Unlock:
    
    @objc func coverSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //payment:
        if !Properties.coverSet2isUnlocked {
            paymentInitiation(setNumber: 3)
        }
        
        //select:
        if Properties.coverSet2isUnlocked && !Properties.coverSet2isSelected {
            Properties.coverSet2isSelected = true
            selectedAnimation(button: shopInterface.coverSet2UnlockButton)

            //deselect another button:
            if Properties.coverSet1isUnlocked {
                Properties.coverSet1isSelected = false
                selectAnimation(button: shopInterface.coverSet1UnlockButton)
            }
            
            //set cover card set in game:
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
        print("Received Payment Transaction Response from Apple")
        transactions.forEach({ transaction in
            switch transaction.transactionState {
            case .purchased:
                print("purchased")
                handlePurchase(transaction.payment.productIdentifier)
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
            case .failed:
                print("failed")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
            case .restored:
                print("restored")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
            default:
                print("default")
//                break
            }
        })
    }
    
    private func paymentInitiation(setNumber: Int) {
        if (SKPaymentQueue.canMakePayments()) {
            let payment = SKPayment(product: self.models[setNumber])
            SKPaymentQueue.default().add(payment)
        }
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
            selectAnimation(button: shopInterface.cardSet1UnlockButton)
            
        case Product.cardSet2.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.cardSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "cardSet2isUnlocked")
            
            //animation:
            selectAnimation(button: shopInterface.cardSet2UnlockButton)
            
        case Product.cardCover1.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.coverSet1isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet1isUnlocked")
            
            //animation:
            selectAnimation(button: shopInterface.coverSet1UnlockButton)
            
            
        case Product.cardCover2.rawValue:
            //audioFX:
            self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            //Properties change:
            Properties.coverSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet2isUnlocked")
            
            //animation:
            selectAnimation(button: shopInterface.coverSet2UnlockButton)
            
        default: return
        }
    }
}
