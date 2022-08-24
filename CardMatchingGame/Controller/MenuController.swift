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
        
        UserDefaults.standard.synchronize()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
        
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
    
    //MARK: - CollectionButtonTapped:
    
    @objc func collectionButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
        transitionToVC(duration: 0.2, identifier: "CollectionController")
    }
    
    //MARK: - Reset Defaults:
    
    @objc func otherButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //reset Defaults:
        UserDefaults.resetDefaults()
        print("defaults RESET!")
    }
    
    //MARK: - Settings Buttons:
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
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
    
    @objc func muteMusicTapped(_ sender: UIButton) {
        SettingController.muteMusicTapped(sender: sender)
    }
    
    @objc func muteSoundTapped(_ sender: UIButton) {
        SettingController.muteSoundTapped(sender: sender)
    }
    
    //MARK: - updateSettingsUIButtonsColor:
    
    func updateSettingsUIButtonsColor() {
        DispatchQueue.main.async {
            self.menuInterface.muteMusicButton.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue) ?? UIColor.systemPink
            self.menuInterface.muteSoundButton.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue) ?? UIColor.systemPink
            self.gameInterface.muteMusicButton.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue) ?? UIColor.systemPink
            self.gameInterface.muteSoundButton.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue) ?? UIColor.systemPink
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
        default: return
        }
    }
    
    
}


