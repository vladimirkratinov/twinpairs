//
//  MenuController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/27.
//

import UIKit
import AVFoundation
import StoreKit
import MessageUI
import StoreKit

class MenuController: UIViewController, SKPaymentTransactionObserver {
    
    var prop = Properties()
    var audioFX = AudioFX()
    let menuInterface = MenuInterface()
    let gameInterface = GameInterface()
    static let gameController = GameController()
    var contentLoader = ContentLoader()
    var gestureRecognizer: UITapGestureRecognizer?
    
    override func loadView() {
        view = menuInterface.menuView
        view.insertSubview(menuInterface.backgroundImageView, at: 0)
                
        menuInterface.setupSubviews()
        menuInterface.setupConstraints()
        
        menuInterface.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        menuInterface.difficultyButton.addTarget(self, action: #selector(difficultyButtonTapped), for: .touchUpInside)
        menuInterface.timeModeButton.addTarget(self, action: #selector(timeModeButtonTapped), for: .touchUpInside)
        menuInterface.hardcoreModeButton.addTarget(self, action: #selector(hardcoreButtonTapped), for: .touchUpInside)
        menuInterface.collectionButton.addTarget(self, action: #selector(collectionButtonTapped), for: .touchUpInside)
        menuInterface.shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        menuInterface.resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        menuInterface.addCoinButton.addTarget(self, action: #selector(addCoinButtonTapped), for: .touchUpInside)
        menuInterface.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        menuInterface.muteMusicButton.addTarget(self, action: #selector(muteMusicTapped), for: .touchUpInside)
        menuInterface.muteSoundButton.addTarget(self, action: #selector(muteSoundTapped), for: .touchUpInside)
        menuInterface.muteVibrationButton.addTarget(self, action: #selector(muteVibrationTapped), for: .touchUpInside)
        menuInterface.rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        menuInterface.contactButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        menuInterface.restorePurchasesButton.addTarget(self, action: #selector(restorePurchasesButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadFiles:
        for i in 1...Properties.listOfSets.count {
            contentLoader.loadSet(setNumber: i)
        }
        
        //load Audio: (fix background music interruption)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .mixWithOthers)
            print("AVAudioSession Category Playback - OK!")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active!")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        //shop observer:
        SKPaymentQueue.default().add(self)
        
        //DEBUGGING:
//        print("Properties.listOfSets.count: \(Properties.listOfSets.count)")
//        print("PROPERTIES: CARD COLLECTION: \(Properties.cardCollection) \n")
//        print("SELECTED SET: \(Properties.selectedCollection)")
//        print("SELECTED CARD LIST: \(Properties.selectedCardList)")
        
        //admin functions:
        if Properties.hideAdminButtons {
            menuInterface.resetButton.isHidden = true
            menuInterface.addCoinButton.isHidden = true
        }
        
        //debug sound:
        print("background music volume: \(String(describing: AudioFX.backgroundMusic?.volume))")
        
        UserDefaults.standard.synchronize()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }, completion: nil)
    
        //Background AudioFX:
        let randomNumber = Int.random(in: 1...2)
        
        let snowfall =      AudioFileKey.Snowfall.rawValue
        let ceremonial =    AudioFileKey.Ceremonial.rawValue
        let mp3File =       AudioTypeKey.mp3.rawValue
        
        if !Properties.generalBackgroundSoundIsMutedForTestPurposes {
            switch randomNumber {
            case 1: try? self.audioFX.playBackgroundMusic(file: snowfall, type: mp3File)
            case 2: try? self.audioFX.playBackgroundMusic(file: ceremonial, type: mp3File)
            default: return
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //background:
//        menuInterface.setGradientBackground()
        //animation:
//        menuInterface.backgroundImageView.pulsateSlow()
        //update Coins label:
        menuInterface.coins = Properties.coins
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        //updateSettingsUIButtonsColor:
        updateSettingsUIButtonsColor()
        
        //Keep Playing AudioFX:
        if AudioFX.backgroundMusic != nil {
            AudioFX.backgroundMusic?.play()
            print("audio is playing")
        }
    }
    
    //MARK: - PlayButtonTapped:
    
    @objc func playButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
        transitionToVC(duration: 0.2, identifier: "GameController")
    }
    
    //MARK: - HardcoreButtonTapped:
    
    @objc func hardcoreButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
//        transitionToVC(duration: 0.2, identifier: "HardcoreController")
    }
    
    //MARK: - CollectionButtonTapped:
    
    @objc func collectionButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
        transitionToVC(duration: 0.2, identifier: "CollectionController")
    }
    
    //MARK: - ShopButtonTapped:
    
    @objc func shopButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
        transitionToVC(duration: 0.2, identifier: "ShopController")
    }
    
    //MARK: - DifficultyButtonTapped:
    
    @objc func difficultyButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if sender.titleLabel?.text == "Difficulty" {
            sender.setTitle("Easy", for: .normal)
            Properties.selectedDifficulty = DifficultyKey.easy.rawValue
            sender.backgroundColor = .green
        } else if sender.titleLabel?.text == DifficultyKey.easy.rawValue {
            sender.setTitle("Medium", for: .normal)
            Properties.selectedDifficulty = DifficultyKey.medium.rawValue
            sender.backgroundColor = .orange
            Properties.rows = 4
            Properties.columns = 3
        } else if sender.titleLabel?.text == DifficultyKey.medium.rawValue {
            sender.setTitle("Hard", for: .normal)
            Properties.selectedDifficulty = DifficultyKey.hard.rawValue
            sender.backgroundColor = .red
            Properties.rows = 5
            Properties.columns = 4
        } else if sender.titleLabel?.text == DifficultyKey.hard.rawValue {
            sender.setTitle("Easy", for: .normal)
            Properties.selectedDifficulty = DifficultyKey.easy.rawValue
            sender.backgroundColor = .green
            Properties.rows = 3
            Properties.columns = 2
        }
    }
    
    //MARK: - TimeModeButtonTapped:
    
    @objc func timeModeButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if sender.titleLabel?.text == TimeKey.threeMinutes.rawValue {
            sender.setTitle("5 min.", for: .normal)
            Properties.standardTimeCounter = 300
            sender.backgroundColor = .orange
            
        } else if sender.titleLabel?.text == TimeKey.fiveMinutes.rawValue {
            sender.setTitle("10 min.", for: .normal)
            Properties.standardTimeCounter = 600
            sender.backgroundColor = .red
            
        } else if sender.titleLabel?.text == TimeKey.tenMinutes.rawValue {
            sender.setTitle("3 min.", for: .normal)
            Properties.standardTimeCounter = 180
            sender.backgroundColor = .green
        }
    }
    
    //MARK: - Reset Button:
    
    @objc func resetButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //reset Defaults:
        DispatchQueue.main.async { [self] in
            UserDefaults.resetDefaults()
            Properties.coins = 0
            menuInterface.coins = 0
            gameInterface.coins = 0
            menuInterface.coinLabel.update { $0.text = "Reset" }
        }
        print("Defaults RESETED!")
    }
    
    //MARK: - Add Coin Button:
    
    @objc func addCoinButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //add Coin:
        menuInterface.coins += 1000
        Properties.coins += 1000
        gameInterface.coins += 1000
        
        Properties.defaults.set(Properties.coins, forKey: CoinsKey.coins.rawValue)
        
        print("properties.coins = \(Properties.coins)")
        print("menuInterface.coins = \(menuInterface.coins)")
        print("gameInterface.coins = \(gameInterface.coins)")
    }
    
    //MARK: - Settings Buttons:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //UI: Hide/Enable
        if menuInterface.settingsView.isHidden {
            menuInterface.settingsView.isHidden =                   false
            menuInterface.coverImageView.isHidden =                 false
            menuInterface.classicModeDescriptionLabel.isHidden =    true
            menuInterface.difficultyDescriptionLabel.isHidden =     true
            menuInterface.timeModeDescriptionLabel.isHidden =       true
            menuInterface.playButton.isHidden =                     true
            menuInterface.difficultyButton.isHidden =               true
            menuInterface.timeModeButton.isHidden =                 true
            menuInterface.titleLabel.text = "settings"
   
        } else {
            menuInterface.settingsView.isHidden =                   true
            menuInterface.coverImageView.isHidden =                 true
            menuInterface.classicModeDescriptionLabel.isHidden =    false
            menuInterface.difficultyDescriptionLabel.isHidden =     false
            menuInterface.timeModeDescriptionLabel.isHidden =       false
            menuInterface.playButton.isHidden =                     false
            menuInterface.difficultyButton.isHidden =               false
            menuInterface.timeModeButton.isHidden =                 false
            menuInterface.titleLabel.text = "Match Pair"
        }
        
    }
    
    @objc func muteMusicTapped(_ sender: UIButton) {
        SettingsController.muteMusicTapped(sender: sender)
    }
    
    @objc func muteSoundTapped(_ sender: UIButton) {
        SettingsController.muteSoundTapped(sender: sender)
    }
    
    @objc func muteVibrationTapped(_ sender: UIButton) {
        SettingsController.muteVibrationTapped(sender: sender)
    }
    
    //MARK: - Rate Button:
    
    @objc func rateButtonTapped(_ sender: UIButton) {        
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        guard let scene = menuInterface.menuView.window?.windowScene else {
            print("no scene")
            return
        }
        
        SKStoreReviewController.requestReview(in: scene)
    }
    
    //MARK: - Contact Button
    
    @objc func contactButtonTapped(_ sender: UIButton) {
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        guard MFMailComposeViewController.canSendMail() else {
            //show alert informing the user
            return
        }
        
        //extension: MFMailComposeViewControllerDelegate
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["matchpairgame@gmail.com"])
        composer.setSubject("Match Pair Feedback")
//        composer.setMessageBody("Greetings Match Pair Team,", isHTML: false)
        
        present(composer, animated: true)
    }
    
    //MARK: - Restore Button:
    
    @objc func restorePurchasesButtonTapped(_ sender: UIButton) {
        print("tapped")
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if (SKPaymentQueue.canMakePayments()) {
          SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Purchased")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
                break
            case .restored:
                print("Restored")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
                break
            case .failed:
                print("Purchased Failed")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
                break
            default:
                print("default")
                break
            }
        }
    }
    
    //MARK: - updateSettingsUIButtonsColor:
    
    func updateSettingsUIButtonsColor() {
        DispatchQueue.main.async {
            let muteMusicColor =        Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            let muteSoundColor =        Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            let muteVibrationColor =    Properties.defaults.colorForKey(key: ColorKey.vibrationButton.rawValue)
            
            //Menu UI:
            self.menuInterface.muteMusicButton.backgroundColor =        muteMusicColor ??       .green
            self.menuInterface.muteSoundButton.backgroundColor =        muteSoundColor ??       .green
            self.menuInterface.muteVibrationButton.backgroundColor =    muteVibrationColor ??   .green
            
            //Game UI:
            self.gameInterface.muteMusicButton.backgroundColor =        muteMusicColor ??       .green
            self.gameInterface.muteSoundButton.backgroundColor =        muteSoundColor ??       .green
            self.gameInterface.muteVibrationButton.backgroundColor =    muteVibrationColor ??   .green
            
            self.menuInterface.muteMusicButton.setTitle(Properties.defaultMusicButtonLabel, for: .normal)
            self.menuInterface.muteSoundButton.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
            self.menuInterface.muteVibrationButton.setTitle(Properties.defaultVibrationButtonLabel, for: .normal)
        }
    }
    
    //MARK: - transitionToVC:
    
    func transitionToVC(duration: Double, identifier: String) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        switch identifier {
        case "CollectionController":
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: identifier) as? CollectionController else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case "GameController":
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: identifier) as? GameController else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case "ShopController":
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: identifier) as? ShopController else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default: return
        }
    }
}
