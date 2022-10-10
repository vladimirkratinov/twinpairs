//
//  SettingButtons.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/22.
//

import UIKit
import StoreKit

class SettingsController {
 
    //MARK: - Mute Music Tapped:
    
    static func muteMusicTapped(sender: UIButton) {
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //set UserProperties.defaults:
        var muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
        //set to have an access in viewDidLoad() to control volume level
        Properties.musicMutedSwitcher = muted
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if muted {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: .green, forKey: ColorKey.musicButton.rawValue)
            Properties.defaults.set(false, forKey: AudioKey.musicIsMuted.rawValue)
            Properties.defaults.set(0.1, forKey: AudioKey.musicVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            
            //set title:
            Properties.defaultMusicButtonLabel = "ON"
            sender.setTitle(Properties.defaultMusicButtonLabel, for: .normal)
            
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        } else {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.musicButton.rawValue)
            Properties.defaults.set(true, forKey: AudioKey.musicIsMuted.rawValue)
            Properties.defaults.set(0, forKey: AudioKey.musicVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
            Properties.defaultMusicButtonLabel = "OFF"
            sender.setTitle(Properties.defaultMusicButtonLabel, for: .normal)
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        }
        print("Music is Muted: \(muted)")
    }
    
    //MARK: - Mute Sound Tapped:
    
    static func muteSoundTapped(sender: UIButton) {
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //set UserProperties.defaults:
        var muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
        //set to have an access in viewDidLoad() to control volume level
        Properties.soundMutedSwitcher = muted
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if muted {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.green, forKey: ColorKey.soundButton.rawValue)
            Properties.defaults.set(false, forKey: AudioKey.soundIsMuted.rawValue)
            Properties.defaults.set(0.1, forKey: AudioKey.soundVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            
            //set title:
            Properties.defaultSoundButtonLabel = "ON"
            sender.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
            
            //audio:
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.additionalAudioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        } else {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.soundButton.rawValue)
            Properties.defaults.set(true, forKey: AudioKey.soundIsMuted.rawValue)
            Properties.defaults.set(0, forKey: AudioKey.soundVolumeLevel.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.soundIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.soundButton.rawValue)
            
            //set title:
            Properties.defaultSoundButtonLabel = "OFF"
            sender.setTitle(Properties.defaultSoundButtonLabel, for: .normal)
            
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.additionalAudioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        }
        print("Sound is Muted: \(muted)")
    }
    
    //MARK: - Mute Vibration Tapped:
    
    static func muteVibrationTapped(sender: UIButton) {
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //set UserProperties.defaults:
        var muted = Properties.defaults.bool(forKey: AudioKey.vibrationIsMuted.rawValue)
        //set to have an access in viewDidLoad() to control volume level
        Properties.vibrationMutedSwitcher = muted
        
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        if muted {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.green, forKey: ColorKey.vibrationButton.rawValue)
            Properties.defaults.set(false, forKey: AudioKey.vibrationIsMuted.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.vibrationIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.vibrationButton.rawValue)
            
            //set title:
            Properties.defaultVibrationButtonLabel = "ON"
            sender.setTitle(Properties.defaultVibrationButtonLabel, for: .normal)
        } else {
            //set UserProperties.defaults:
            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.vibrationButton.rawValue)
            Properties.defaults.set(true, forKey: AudioKey.vibrationIsMuted.rawValue)
            
            //get UserProperties.defaults:
            muted = Properties.defaults.bool(forKey: AudioKey.vibrationIsMuted.rawValue)
            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.vibrationButton.rawValue)
            
            //set title:
            Properties.defaultVibrationButtonLabel = "OFF"
            sender.setTitle(Properties.defaultVibrationButtonLabel, for: .normal)
        }
        print("Vibration is Muted: \(muted)")
    }
    
    //MARK: - Background Button Tapped:
    
    static func backgroundButtonTapped(sender: UIButton) {
        let audioFX = AudioFX()
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        //Changing color: first delete sublayer - than replace it with proper gradient
        Properties.backgroundGradientSwitcher += 1
        changingBackgroundGradient()
        
        print(Properties.backgroundGradientSwitcher)
    }
    
    //turned off
    static func changingBackgroundGradient() {
        if Properties.backgroundGradientSwitcher == 1 {
            GameInterface.backgroundImageView.layer.sublayers = nil
            GameInterface.backgroundImageView.setGradientBackground1()
 
        } else if Properties.backgroundGradientSwitcher == 2 {
            GameInterface.backgroundImageView.layer.sublayers = nil
            GameInterface.backgroundImageView.setGradientBackground2()

        } else if Properties.backgroundGradientSwitcher == 3 {
            GameInterface.backgroundImageView.layer.sublayers = nil
            GameInterface.backgroundImageView.setGradientBackground3()
        } else {
            Properties.backgroundGradientSwitcher = 1
            GameInterface.backgroundImageView.layer.sublayers = nil
            GameInterface.backgroundImageView.setGradientBackground1()
        }
    }
}
