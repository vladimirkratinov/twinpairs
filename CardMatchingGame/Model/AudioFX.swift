//
//  AudioFX.swift
//  hangman
//
//  Created by Vladimir Kratinov on 2022/1/21.
//

import UIKit
import AVFoundation

class AudioFX {
    var audioFX: AVAudioPlayer?
    static var backgroundMusic: AVAudioPlayer?
    var gameStateFX: AVAudioPlayer?
    
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
            audioFX = try AVAudioPlayer(contentsOf: url)
            audioFX?.volume = 0.2
            audioFX?.play()
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
            gameStateFX = try AVAudioPlayer(contentsOf: url)
            gameStateFX?.volume = 0.2
            gameStateFX?.play()
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
        
        
        if Properties.mutedGeneral {
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.volumeLevel.rawValue)
        } else {
            AudioFX.backgroundMusic?.volume = Properties.defaults.float(forKey: AudioKey.volumeLevel.rawValue)
        }
    }
    
}
