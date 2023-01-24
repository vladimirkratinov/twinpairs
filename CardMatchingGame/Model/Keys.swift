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

enum FigmaKey: String {
    case backgroundCardList1 = "BackgroundCardList1"
    case backgroundCardList2 = "BackgroundCardList2"
    case backgroundGame = "BackgroundGame"
    case backgroundMenu = "BackgroundMenu"
    case backgroundShop = "BackgroundShop"
    case backgroundSettings = "BackgroundSettings"
    case backgroundGameOver = "BackgroundGameOver"
    case shopBlockBackground1 = "ShopBlockBackground1"
    case shopBlockBackground2 = "ShopBlockBackground2"
    case logo = "Logo"
    case settings = "Settings"
    case paperTexture = "PaperTexture"
    case gradientTexture1 = "GradientTexture1"
    case gradientTexture2 = "GradientTexture2"
    case gradientTexture3 = "GradientTexture3"
    case lock = "Lock"
    case cardCover1 = "CardCover1"
    case cardCover2 = "CardCover2"
    case cardCover3 = "CardCover3"
    case shop_cover_1 = "shop_cover_1"
    case shop_cover_2 = "shop_cover_2"
    case shop_cover_3 = "shop_cover_3"
}

enum FontKey: String {
    case staatliches =                      "Staatliches-Regular"
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
    
    //180:
    
    case Easy180Pairs = "Easy180Pairs"
    case Easy180Flips = "Easy180Flips"
    case Easy180Score = "Easy180Score"
    
    case Medium180Pairs = "Medium180Pairs"
    case Medium180Flips = "Medium180Flips"
    case Medium180Score = "Medium180Score"
    
    case Hard180Pairs = "Hard180Pairs"
    case Hard180Flips = "Hard180Flips"
    case Hard180Score = "Hard180Score"
    
    //300:
    
    case Easy300Pairs = "Easy300Pairs"
    case Easy300Flips = "Easy300Flips"
    case Easy300Score = "Easy300Score"
    
    case Medium300Pairs = "Medium300Pairs"
    case Medium300Flips = "Medium300Flips"
    case Medium300Score = "Medium300Score"
    
    case Hard300Pairs = "Hard300Pairs"
    case Hard300Flips = "Hard300Flips"
    case Hard300Score = "Hard300Score"
    
    //600:
    
    case Easy600Pairs = "Easy600Pairs"
    case Easy600Flips = "Easy600Flips"
    case Easy600Score = "Easy600Score"
    
    case Medium600Pairs = "Medium600Pairs"
    case Medium600Flips = "Medium600Flips"
    case Medium600Score = "Medium600Score"
    
    case Hard600Pairs = "Hard600Pairs"
    case Hard600Flips = "Hard600Flips"
    case Hard600Score = "Hard600Score"
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
    case victory_old =          "victory_old"
    case buttonPress =          "buttonPress"
    case tinyButtonPress =      "tinyButtonPress"
    case shiny =                "shiny"
    case lockSound =            "lockSound"
    case magic =                "magic"
    case padlock =              "padlock"
    case cardShuffle =          "cardShuffle"
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
    
    case defaultMusicButtonLabel =      "defaultMusicButtonLabel"
    case defaultSoundButtonLabel =      "defaultSoundButtonLabel"
    case defaultVibrationButtonLabel =  "defaultVibrationButtonLabel"
}

enum ColorKey: String {
    case musicButton =          "musicButton"
    case soundButton =          "soundButton"
    case vibrationButton =      "vibrationButton"
}

enum DifficultyKey: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum TimeKey: String {
    case threeMinutes = "3 min."
    case fiveMinutes = "5 min."
    case tenMinutes = "10 min."
}

enum SettingsKey: String {
    case musicLabel = "musicLabel"
    case soundLabel = "soundLabel"
    case vibrationLabel = "vibrationLabel"
}
