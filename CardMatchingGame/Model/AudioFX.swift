//
//  AudioFX.swift
//  hangman
//
//  Created by Vladimir Kratinov on 2022/1/21.
//

import UIKit
import AVFoundation

class AudioFX {
    static var audioFX: AVAudioPlayer?
    static var gameStateFX: AVAudioPlayer?
    static var backgroundMusic: AVAudioPlayer?
    
    func stopMusic() {
        AudioFX.backgroundMusic?.stop()
    }
    
    func playFX(file: String, type: String) throws {
        
        enum AudioError: Error {
            case FileNotExist
        }
        
        guard let pathToSound = Bundle.main.path(forResource: file, ofType: type) else { return }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            AudioFX.audioFX = try AVAudioPlayer(contentsOf: url)
            AudioFX.audioFX?.volume = 0.2
            AudioFX.audioFX?.play()
        } catch {
            print("\(file).\(type) was not found.")
            throw AudioError.FileNotExist
        }
    }
    
    func playGameStateFX(file: String, type: String) throws {
        
        enum AudioError: Error {
            case FileNotExist
        }
        
        guard let pathToSound = Bundle.main.path(forResource: file, ofType: type) else { return }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            AudioFX.gameStateFX = try AVAudioPlayer(contentsOf: url)
            AudioFX.gameStateFX?.volume = 0.2
            AudioFX.gameStateFX?.play()
        } catch {
            print("\(file).\(type) was not found.")
            throw AudioError.FileNotExist
        }
    }
    
    @objc func playBackgroundMusic(file: String, type: String) throws {
        
        enum AudioError: Error {
            case FileNotExist
        }
        
        guard let pathToSound = Bundle.main.path(forResource: file, ofType: type) else { return }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            AudioFX.backgroundMusic = try AVAudioPlayer(contentsOf: url)
            AudioFX.backgroundMusic?.volume = 0.1
            AudioFX.backgroundMusic?.play()
        } catch {
            print("\(file).\(type) was not found.")
            throw AudioError.FileNotExist
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
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
        
        
        if Properties.musicMutedSwitcher {
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        } else {
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.musicVolumeLevel.rawValue)
        }
        
        if Properties.soundMutedSwitcher {
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.gameStateFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        } else {
            AudioFX.audioFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
            AudioFX.gameStateFX?.volume = Properties.defaults.float(forKey: AudioKey.soundVolumeLevel.rawValue)
        }
    }
    
}
