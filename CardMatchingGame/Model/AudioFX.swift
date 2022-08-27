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
    static var additionalAudioFX: AVAudioPlayer?
    static var backgroundMusic: AVAudioPlayer?
    
    let mp3 =               AudioTypeKey.mp3.rawValue
    let wav =               AudioTypeKey.wav.rawValue
    let flac =              AudioTypeKey.flac.rawValue
    let tinyButton =        AudioFileKey.tinyButtonPress.rawValue
    let buttonPress =       AudioFileKey.buttonPress.rawValue
    let flip1 =             AudioFileKey.flip1.rawValue
    let flip2 =             AudioFileKey.flip2.rawValue
    let flip3 =             AudioFileKey.flip3.rawValue
    let matchIgnite =       AudioFileKey.matchIgnite.rawValue
    let victory =           AudioFileKey.victory.rawValue
    let gameOver =          AudioFileKey.gameOver.rawValue
    let shiny =             AudioFileKey.shiny.rawValue
    let lockSound =         AudioFileKey.lockSound.rawValue
    let padlock =           AudioFileKey.padlock.rawValue
    let magic =             AudioFileKey.magic.rawValue
    
    func stopMusic() {
        AudioFX.backgroundMusic?.stop()
    }
    
    func openAudioFile(file: String, type: String) throws {
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
    
    func openAnotherAudioFile(file: String, type: String) throws {
        enum AudioError: Error {
            case FileNotExist
        }
        
        guard let pathToSound = Bundle.main.path(forResource: file, ofType: type) else { return }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            AudioFX.additionalAudioFX = try AVAudioPlayer(contentsOf: url)
            AudioFX.additionalAudioFX?.volume = 0.1
            AudioFX.additionalAudioFX?.play()
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

        switch isMuted {
        case true:
            switch name {
            case tinyButton:    try? openAudioFile(file: tinyButton, type: wav)
            case buttonPress:   try? openAudioFile(file: buttonPress, type: wav)
            case flip1:         try? openAudioFile(file: flip1, type: wav)
            case flip2:         try? openAudioFile(file: flip2, type: wav)
            case flip3:         try? openAudioFile(file: flip3, type: wav)
            case matchIgnite:   try? openAnotherAudioFile(file: matchIgnite, type: wav)
            case victory:       try? openAudioFile(file: victory, type: wav)
            case gameOver:      try? openAudioFile(file: gameOver, type: wav)
            case shiny:         try? openAudioFile(file: shiny, type: flac)
            case magic:         try? openAudioFile(file: magic, type: flac)
            case lockSound:     try? openAudioFile(file: lockSound, type: flac)
            case padlock:       try? openAudioFile(file: padlock, type: flac)
            default:            return
            }
        default: return
        }
    }
    
    func playAnotherSoundFX(name: String, isMuted: Bool) {

        switch isMuted {
        case true:
            switch name {
            case tinyButton:    try? openAudioFile(file: tinyButton, type: wav)
            case buttonPress:   try? openAudioFile(file: buttonPress, type: wav)
            case flip1:         try? openAudioFile(file: flip1, type: wav)
            case flip2:         try? openAudioFile(file: flip2, type: wav)
            case flip3:         try? openAudioFile(file: flip3, type: wav)
            case matchIgnite:   try? openAnotherAudioFile(file: matchIgnite, type: wav)
            case victory:       try? openAudioFile(file: victory, type: wav)
            case gameOver:      try? openAudioFile(file: gameOver, type: wav)
            case shiny:         try? openAudioFile(file: shiny, type: flac)
            case magic:         try? openAudioFile(file: magic, type: flac)
            case lockSound:     try? openAudioFile(file: lockSound, type: flac)
            case padlock:       try? openAudioFile(file: padlock, type: flac)
            default:            return
            }
        default: return
        }
    }
}
    

