//
//  AudioFX.swift
//  hangman
//
//  Created by Vladimir Kratinov on 2022/1/21.
//

import UIKit
import AVFoundation

struct AudioFX {
    
    let defaults = UserDefaults.standard
    var audioFX: AVAudioPlayer?
    var backgroundMusic: AVAudioPlayer?
    var gameStateFX: AVAudioPlayer?
    
    mutating func stopMusic() {
        backgroundMusic?.stop()
    }
    
    mutating func playFX(file: String, type: String) throws {
        
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
    
    mutating func playGameStateFX(file: String, type: String) throws {
        
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
    
    mutating func playBackgroundMusic(file: String, type: String) throws {
        
        enum AudioError: Error {
            case FileNotExist
        }
        
        guard let pathToSound = Bundle.main.path(forResource: file, ofType: type) else { return }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.volume = 0.1
            backgroundMusic?.play()
        } catch {
            print("\(file).\(type) was not found.")
            throw AudioError.FileNotExist
        }
    }
}
