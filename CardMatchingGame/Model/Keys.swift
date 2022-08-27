//
//  Keys.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/6.
//

import Foundation

enum CoinsKey: String {
    case coins = "Coins"
}

enum ImageKey: String {
    case wood1 = "wood1"
    case wood2 = "wood2"
    case wood3 = "wood3"
    case wood4 = "wood4"
    case wood5 = "wood5"
    
    case stampBackground =  "background"
    case SettingsButton =   "settings2"
    case selectButton =     "selectButton"
    
    case envelope1 =            "envelope1"
    case envelope2 =            "envelope2"
    case envelope3 =            "envelope3"
    case envelope4Large =       "envelope4Large"
    case envelope4Medium =      "envelope4Medium"
    
    case LaunchScreen1 = "LaunchScreen1"
    case LaunchScreen2 = "LaunchScreen2"
    case LaunchScreen3 = "LaunchScreen3"
    
    case lock1 = "lock1"
    case lock2 = "lock2"
    case lock3 = "lock3"
}

enum FontKey: String {
    case FuturaExtraBold =                  "Futura-CondensedExtraBold"
    case AcademyEngravedLetPlain =          "AcademyEngravedLetPlain"
    case AmericanTypewriter =               "AmericanTypewriter"
    case AmericanTypewriterBold =           "AmericanTypewriter-Bold"
    case AmericanTypewriterLight =          "AmericanTypewriter-Light"
    case AmericanTypewriterCondensed =      "AmericanTypewriter-Condensed"
    case AmericanTypewriterCondensedBold =  "AmericanTypewriter-CondensedBold"
    case AmericanTypewriterCondensedLight = "AmericanTypewriter-CondensedLight"
}

enum StatisticsKey: String {
    case time =     "time"
    case pairs =    "pairs"
    case flips =    "flips"
}

enum AudioFileKey: String {
    case Ceremonial =           "Ceremonial"
    case Snowfall =             "Snowfall"
    case creepy =               "creepy"
    case flip1 =                "flip1"
    case flip2 =                "flip2"
    case flip3 =                "flip3"
    case flop =                 "flop"
    case gameOver =             "gameOver"
    case match =                "match"
    case matchIgnite =          "matchIgnite"
    case victory =              "victory"
    case buttonPress =          "buttonPress"
    case tinyButtonPress =      "tinyButtonPress"
    case shiny =                "shiny"
    case lockSound =            "lockSound"
    case magic =                "magic"
    case padlock =              "padlock"
}

enum AudioTypeKey: String {
    case wav = "wav"
    case mp3 = "mp3"
    case flac = "flac"
}

enum AudioKey: String {
    case musicIsMuted =         "musicIsMuted"
    case soundIsMuted =         "soundIsMuted"
    case vibrationIsMuted =     "vibrationIsMuted"
    case musicVolumeLevel =     "musicVolumeLevel"
    case soundVolumeLevel =     "soundVolumeLevel"
}

enum ColorKey: String {
    case musicButton =          "musicButton"
    case soundButton =          "soundButton"
    case vibrationButton =      "vibrationButton"
}
