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
            AudioFX.audioFX?.volume = 0.1
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
            AudioFX.gameStateFX?.volume = 0.1
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
            AudioFX.backgroundMusic?.volume = 0.2
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
    }
    
    //MARK: - PlaySoundFX:
    
    func playSoundFX(name: String, isMuted: Bool) {
        let tinyButton =        AudioFileKey.tinyButtonPress.rawValue
        let buttonPress =       AudioFileKey.buttonPress.rawValue
        let flip1 =             AudioFileKey.flip1.rawValue
        let flip2 =             AudioFileKey.flip2.rawValue
        let matchIgnite =       AudioFileKey.matchIgnite.rawValue
        let victory =           AudioFileKey.victory.rawValue
        let gameOver =          AudioFileKey.gameOver.rawValue
        let wav =               AudioTypeKey.wav.rawValue
        
        switch isMuted {
        case true:
            switch name {
            case tinyButton:    try? playFX(file: tinyButton, type: wav)
            case buttonPress:   try? playFX(file: buttonPress, type: wav)
            case flip1:         try? playFX(file: flip1, type: wav)
            case flip2:         try? playFX(file: flip2, type: wav)
            case matchIgnite:   try? playGameStateFX(file: matchIgnite, type: wav)
            case victory:       try? playFX(file: victory, type: wav)
            case gameOver:      try? playFX(file: gameOver, type: wav)
            default:            return
            }
        default: return
        }
    }
}
    

