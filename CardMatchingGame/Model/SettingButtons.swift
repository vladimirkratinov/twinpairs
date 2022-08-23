////
////  SettingButtons.swift
////  CardMatchingGame
////
////  Created by Vladimir Kratinov on 2022/8/22.
////
//
//import UIKit
//
//public class SettingButtons {
//    
//    //MARK: - MuteButtonTapped:
//    
//    @objc static func muteMusicTapped(_ sender: UIButton) {
//        //animation:
//        sender.bounce(sender)
//        //set UserProperties.defaults:
//        var muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
//        
//        //set to have an access in viewDidLoad() to control volume level
//        Properties.musicMutedSwitcher = muted
//        
//        //audioFX:
//        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
//        
//        if muted {
//            //set UserProperties.defaults:
//            Properties.defaults.setColor(color: UIColor.systemPink, forKey: ColorKey.musicButton.rawValue)
//            Properties.defaults.set(false, forKey: AudioKey.musicIsMuted.rawValue)
//            Properties.defaults.set(0.1, forKey: AudioKey.musicVolumeLevel.rawValue)
//            
//            //get UserProperties.defaults:
//            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
//            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
//            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
//        } else {
//            //set UserProperties.defaults:
//            Properties.defaults.setColor(color: UIColor.gray, forKey: ColorKey.musicButton.rawValue)
////            sender.backgroundColor = UIColor.gray
//            Properties.defaults.set(true, forKey: AudioKey.musicIsMuted.rawValue)
//            Properties.defaults.set(0, forKey: AudioKey.musicVolumeLevel.rawValue)
//            
//            //get UserProperties.defaults:
//            muted = Properties.defaults.bool(forKey: AudioKey.musicIsMuted.rawValue)
//            sender.backgroundColor = Properties.defaults.colorForKey(key: ColorKey.musicButton.rawValue)
//            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
//        }
//        print(muted)
//    }
//}
