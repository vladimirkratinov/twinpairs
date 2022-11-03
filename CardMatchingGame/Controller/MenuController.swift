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

class MenuController: UIViewController, UIGestureRecognizerDelegate {
    var prop = Properties()
    var audioFX = AudioFX()
    let menuInterface = MenuInterface()
    let gameInterface = GameInterface()
    let defaults = UserDefaults.standard
    static let gameController = GameController()
    var contentLoader = ContentLoader()
    var gestureRecognizer: UITapGestureRecognizer?
    let recipientEmail = "twinpairsgame@gmail.com"
    
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
        menuInterface.tutorialButton.addTarget(self, action: #selector(tutorialButtonTapped), for: .touchUpInside)
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

        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //load tutorial slides:
        contentLoader.loadTutorial()
        //loadFiles:
        loadFiles()
        
        //load Audio: (fix background music interruption)
        audioFX.loadAudio()
        
        //present tutorial at the first launch:
        if !Properties.tutorialCompleted {
            transitionToVC(duration: 0.5, identifier: "TutorialController")
            Properties.tutorialCompleted = true
            Properties.defaults.set(true, forKey: "tutorialCompleted")
        }
        
        //turn off sound defaults:
        if defaults.bool(forKey: AudioKey.soundIsMuted.rawValue) {
            Properties.soundMutedSwitcher = false
        }
        
        
        //shop observer:
//        SKPaymentQueue.default().add(self)
        
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

//        if !Properties.muteBackgroundMusic {
//            switch randomNumber {
//            case 1: try? self.audioFX.playBackgroundMusic(file: snowfall, type: mp3File)
//            case 2: try? self.audioFX.playBackgroundMusic(file: ceremonial, type: mp3File)
//            default: return
//            }
//        }
        
        if !defaults.bool(forKey: AudioKey.musicIsMuted.rawValue) { //  !Properties.muteBackgroundMusic
            if AudioFX.myQueuePlayer == nil {
                audioFX.playQueueBackgroundMusic()
                // instantiate the AVQueuePlayer with all avItems
                AudioFX.myQueuePlayer = AVQueuePlayer(items: AudioFX.avItems)
                // start playing
                AudioFX.myQueuePlayer?.play()
                AudioFX.myQueuePlayer?.volume = 0.2
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true

    }
    
    //MARK: - Load Files:
    
    func loadFiles() {
        for i in 1...Properties.listOfSets.count {
            contentLoader.loadSet(setNumber: i)
        }
    }
    
    //MARK: - PlayButtonTapped:
    
    @objc func playButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
//        audioFX.playFirstSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //transition:
        transitionToVC(duration: 0.2, identifier: "GameController")
    }
    
    //MARK: - DifficultyButtonTapped:
    
    @objc func difficultyButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
//        audioFX.playFirstSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
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
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
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
    
    //MARK: - CollectionButtonTapped:
    
    @objc func collectionButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //transition:
        transitionToVC(duration: 0.2, identifier: "CollectionController")
    }
    
    //MARK: - ShopButtonTapped:
    
    @objc func shopButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //transition:
        transitionToVC(duration: 0.2, identifier: "ShopController")
    }
    
    //MARK: - TutorialButtonTapped:
    
    @objc func tutorialButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //transition:
        transitionToVC(duration: 0.2, identifier: "TutorialController")
    }
    
    //MARK: - Reset Button:
    
    @objc func resetButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
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
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //add Coin:
        menuInterface.coins += 1000
        Properties.coins += 1000
        gameInterface.coins += 1000
        
        Properties.defaults.set(Properties.coins, forKey: CoinsKey.coins.rawValue)
        
        print("properties.coins = \(Properties.coins)")
        print("menuInterface.coins = \(menuInterface.coins)")
        print("gameInterface.coins = \(gameInterface.coins)")
    }
    
    //MARK: - HardcoreButtonTapped:
    
    @objc func hardcoreButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        //transition:
//        transitionToVC(duration: 0.2, identifier: "HardcoreController")
    }
    
    //MARK: - Settings Buttons:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
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
            menuInterface.tutorialButton.isHidden =                 true
            menuInterface.largeTitleLabel.text = "settings"
   
        } else {
            menuInterface.settingsView.isHidden =                   true
            menuInterface.coverImageView.isHidden =                 true
            menuInterface.classicModeDescriptionLabel.isHidden =    false
            menuInterface.difficultyDescriptionLabel.isHidden =     false
            menuInterface.timeModeDescriptionLabel.isHidden =       false
            menuInterface.playButton.isHidden =                     false
            menuInterface.difficultyButton.isHidden =               false
            menuInterface.timeModeButton.isHidden =                 false
            menuInterface.tutorialButton.isHidden =                 false
            menuInterface.largeTitleLabel.text = "Twin Pairs"
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
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
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
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
        
        if MFMailComposeViewController.canSendMail() {
            self.sendEmail()
        } else {
            if let emailUrl = createEmailUrl(to: recipientEmail,
                                             subject: "Subject", body: "Send from my iPhone") {
                UIApplication.shared.open(emailUrl)
            }
        }
    }
    
    func sendEmail(){
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["twinpairsgame@gmail.com"])
        composer.setSubject("Twin Pairs Game Feedback")
        self.present(composer, animated: true, completion: nil)
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    //MARK: - Restore Button:
    
    @objc func restorePurchasesButtonTapped(_ sender: UIButton) {
        print("tapped")
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playFirstSoundFX( name: AudioFileKey.buttonPress.rawValue,
                                  isMuted: !Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue))
        
//        if (SKPaymentQueue.canMakePayments()) {
//          SKPaymentQueue.default().restoreCompletedTransactions()
//        }
    }
    
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        print("Received Payment Transaction Response from Apple");
//        for transaction in transactions {
//            switch transaction.transactionState {
//            case .purchased:
//                print("menu controller: purchased")
//                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
//            case .restored:
//                print("menu controller: restored")
//                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
//            case .failed:
//                print("menu controller: failed")
//                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                break
//            default:
//                print("default")
//                break
//            }
//        }
//    }
    
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
        case "TutorialController":
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: identifier) as? TutorialController else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default: return
        }
    }
}

