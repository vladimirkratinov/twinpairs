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

class ShopController: UIViewController, UIGestureRecognizerDelegate, SKPaymentTransactionObserver  {
    //SKProductsRequestDelegate
    let shopInterface = ShopInterface()
    let shiny = AudioFileKey.shiny.rawValue
    let audioFX = AudioFX()
    let prop = Properties()
    let palette = Palette()
    var counter1 = 0
    var counter2 = 0
    var newArray1WithoutDuplicates: [String] = []
    var newArray2WithoutDuplicates: [String] = []
    
//    private var models = [SKProduct]()
    
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
        
        shopInterface.restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //transparent NavigationBar:
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        let restore = UIBarButtonItem(title: "Restore Purchases",
                                      style: .plain,
                                      target: self,
                                      action: #selector(restoreButtonTapped))
        navigationItem.rightBarButtonItem = restore
        
        //observer:
        SKPaymentQueue.default().add(self)
        
        loadNewSetsIntoImageButtonsForTapAnimation()
        
        DispatchQueue.main.async {
            self.updateShopUI()
        }
        
//        fetchProducts()
        
        print("cardSet1isUnlocked: \(Properties.cardSet1isUnlocked)")
        print("cardSet1isSelected: \(Properties.cardSet1isSelected)")
        print("cardSet2isUnlocked: \(Properties.cardSet2isUnlocked)")
        print("cardSet2isSelected: \(Properties.cardSet2isSelected)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //enable gestures:
        title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backItem?.backButtonTitle = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        case cardset1 =     "com.vladimirkratinov.twinpairs.cardset1"
        case cardset2 =     "com.vladimirkratinov.twinpairs.cardset2"
        case coverset1 =    "com.vladimirkratinov.twinpairs.coverset1"
        case coverset2 =    "com.vladimirkratinov.twinpairs.coverset2"
    }
    
    let productID = [ "com.vladimirkratinov.twinpairs.cardset1",
                      "com.vladimirkratinov.twinpairs.cardset2",
                      "com.vladimirkratinov.twinpairs.coverset1",
                      "com.vladimirkratinov.twinpairs.coverset2"
    ]
    
//    private func fetchProducts() {
//        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue})))
//        request.delegate = self
//        request.start()
//    }
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        DispatchQueue.main.async {
//            print("Shop products: \(response.products.count)")
//            self.models = response.products
//        }
//    }
    
    private func paymentInitiation(setNumber: Int) {
        //old code:
//        if (SKPaymentQueue.canMakePayments()) {
//            let payment = SKPayment(product: self.models[setNumber])
//            SKPaymentQueue.default().add(payment)
//        }
        
        //new code (dummy - AlertController - Testing):
        let ac = UIAlertController(title: "Purchase", message: "The operation window is temporarily unavailable due to the current testing stage (It will be available in the subsequent build updates).", preferredStyle: .alert)
        let unlock = UIAlertAction(title: "Unlock", style: .destructive) { _ in
            switch setNumber {
            case 0: self.handlePurchase(self.productID[0])
            case 1: self.handlePurchase(self.productID[1])
            case 2: self.handlePurchase(self.productID[2])
            case 3: self.handlePurchase(self.productID[3])
            default: return
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(unlock)
        ac.addAction(cancel)
        
        present(ac, animated: true)

        //new code (StoreKit):
//        if SKPaymentQueue.canMakePayments() {
//
//            //Can make payments
//            print("Can make payment")
//            let  paymentRequest = SKMutablePayment()
//            paymentRequest.productIdentifier = productID[setNumber]
//            SKPaymentQueue.default().add(paymentRequest)
//
//        } else {
//            //Can't make payments
//            print("Can't make payment")
//        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple")
        for transaction in transactions {
            
            if transaction.transactionState == .purchased {
                print("shop controller: purchased")
                print("payment product identifier = \(transaction.payment.productIdentifier)")
                handlePurchase(transaction.payment.productIdentifier)
                
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)

            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("shop controller: failed - \(errorDescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
                
            } else if transaction.transactionState == .restored {
                print("shop controller: restored")
                
                if transaction.payment.productIdentifier == productID[0] {
                    handlePurchase(productID[0])
                } else if transaction.payment.productIdentifier == productID[1] {
                    handlePurchase(productID[1])
                } else if transaction.payment.productIdentifier == productID[2] {
                    handlePurchase(productID[2])
                } else if transaction.payment.productIdentifier == productID[3] {
                    handlePurchase(productID[3])
                }

                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
            }
        }
    }
    
    @objc func restoreButtonTapped(_ sender: Any) {
        //animation:
//        (sender as UIButton).bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        print("restore button tapped!")
        SKPaymentQueue.default().restoreCompletedTransactions()
        
        let ac = UIAlertController(title: "Message", message: "Restore purchases is temporarily unavailable due to the current testing stage.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .cancel)
        ac.addAction(dismiss)
        present(ac, animated: true)
    }
    
    func handlePurchase(_ id: String) {
        print("handle purchase method id  = \(id)")
        //audioFX:
        self.audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
        
        switch id {
        case Product.cardset1.rawValue:
            Properties.cardSet1isUnlocked = true
            Properties.defaults.set(true, forKey: "cardSet1isUnlocked")
            selectAnimation(button: shopInterface.cardSet1UnlockButton)
            
        case Product.cardset2.rawValue:
            Properties.cardSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "cardSet2isUnlocked")
            selectAnimation(button: shopInterface.cardSet2UnlockButton)
            
        case Product.coverset1.rawValue:
            Properties.coverSet1isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet1isUnlocked")
            selectAnimation(button: shopInterface.coverSet1UnlockButton)
            
        case Product.coverset2.rawValue:
            Properties.coverSet2isUnlocked = true
            Properties.defaults.set(true, forKey: "coverSet2isUnlocked")
            selectAnimation(button: shopInterface.coverSet2UnlockButton)
            
        default: return
            
        }
    }
}
