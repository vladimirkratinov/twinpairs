//
//  MenuController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/27.
//

import UIKit
import AVFoundation

class MenuController: UIViewController {
    
    var prop = Properties()
    var audioFX = AudioFX()
    let menuInterface = MenuInterface()
    let gameInterface = GameInterface()
    static let gameController = GameController()
    var contentLoader = ContentLoader()
    var gestureRecognizer: UITapGestureRecognizer?
//    var settingsButtons = SettingButtons()
    
    override func loadView() {
        view = menuInterface.menuView
        view.insertSubview(menuInterface.backgroundImageView, at: 0)
        
        menuInterface.setupSubviews()
        menuInterface.setupConstraints()
        
        menuInterface.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        menuInterface.collectionButton.addTarget(self, action: #selector(collectionButtonTapped), for: .touchUpInside)
        
        menuInterface.otherButton.addTarget(self, action: #selector(otherButtonTapped), for: .touchUpInside)
        
        menuInterface.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        menuInterface.muteMusicButton.addTarget(self, action: #selector(muteMusicTapped), for: .touchUpInside)
        menuInterface.muteSoundButton.addTarget(self, action: #selector(muteSoundTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
        
//        //Tap Gesture Settings:
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(closeView),
//                                               name: NSNotification.Name("CloseView"),
//                                               object: nil)
//        //gesture Recognizer:
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
//        view.addGestureRecognizer(gesture)
//        self.gestureRecognizer = gesture
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }, completion: nil)
        
        //loadFiles:
        for i in 1...6 {
            contentLoader.loadSet(setNumber: i)
        }
        
//        //Background AudioFX:
        let randomNumber = Int.random(in: 1...2)
        switch randomNumber {
        case 1: try? self.audioFX.playBackgroundMusic(file: AudioFileKey.Snowfall.rawValue, type: AudioTypeKey.mp3.rawValue)
        case 2: try? self.audioFX.playBackgroundMusic(file: AudioFileKey.Ceremonial.rawValue, type: AudioTypeKey.mp3.rawValue)
        default: return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //background:
        menuInterface.setGradientBackground()
        //animation:
        menuInterface.backgroundImageView.pulsateSlow()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Background AudioFX:
        
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
//        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")

        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "GameController") as? GameController else { return }
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //MARK: - CollectionButtonTapped:
    
    @objc func collectionButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "CollectionController") as? CollectionController else { return }
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //MARK: - RESET!!!:
    
    @objc func otherButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")
        //reset Defaults:
        resetStatisticsUserDefaults()
    }
    
    fileprivate func resetStatisticsUserDefaults() {
        UserDefaults.standard.reset()
        print("defaults RESET!")
    }
    
    //MARK: - Settings Button Tapped:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        //UI Hide/Enable
        if menuInterface.settingsView.isHidden {
            menuInterface.settingsView.isHidden = false
            menuInterface.coverImageView.isHidden = false
            menuInterface.menuView.viewWithTag(1)?.isUserInteractionEnabled = false
            
        } else {
            menuInterface.settingsView.isHidden = true
            menuInterface.coverImageView.isHidden = true
            menuInterface.menuView.viewWithTag(1)?.isUserInteractionEnabled = true
        }
    }
    
    //MARK: - Dismiss Settings Veiw:
    
//    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
//        let location = tapGestureRecognizer.location(in: menuInterface.settingsView)
//        guard menuInterface.settingsView.isHidden == false,
//              !menuInterface.settingsView.bounds.contains(location) else {  //We need to have tapped outside of view 2
//            return
//        }
//        menuInterface.settingsView.isHidden = true
//    }
    
    //MARK: - MuteButtonTapped:
    
    @objc func muteMusicTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //set UserProperties.defaults:
        var muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
        
        //set to have an access in viewDidLoad() to control volume level
        Properties.musicMutedSwitcher = muted
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        if muted {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.systemPink, forKey: ColorKey.musicButton.rawValue)
            Properties.defaults.set(false, forKey: AudioKey.musicIsMuted.rawValue)
            Properties.defaults.set(0.1, forKey: AudioKey.musicVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        } else {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.musicButton.rawValue)
//            sender.backgroundColor = UIColor.gray
            Properties.defaults.set(true, forKey: AudioKey.musicIsMuted.rawValue)
            Properties.defaults.set(0, forKey: AudioKey.musicVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        }
        print(muted)
    }
    
    //MARK: - MuteSoundTapped:
    
    @objc func muteSoundTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //set UserProperties.defaults:
        var muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
        
        //set to have an access in viewDidLoad() to control volume level
        Properties.soundMutedSwitcher = muted
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
//        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        if muted {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.systemPink, forKey: ColorKey.soundButton.rawValue)
            Properties.defaults.set(false, forKey: AudioKey.soundIsMuted.rawValue)
            Properties.defaults.set(0.1, forKey: AudioKey.soundVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.gameStateFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        } else {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.soundButton.rawValue)
//            sender.backgroundColor = UIColor.gray
            Properties.defaults.set(true, forKey: AudioKey.soundIsMuted.rawValue)
            Properties.defaults.set(0, forKey: AudioKey.soundVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.gameStateFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        }
        print(muted)
        
    }
    
    
    
    
}


