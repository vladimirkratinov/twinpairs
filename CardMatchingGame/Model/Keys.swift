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
    case backImage = "Back1Medium"
}

enum FontKey: String {
    case FuturaExtraBold = "Futura-CondensedExtraBold"
}

enum StatisticsKey: String {
    case time = "time"
    case pairs = "pairs"
    case flips = "flips"
}

enum AudioFileKey: String {
    case CeremonialBackground = "Ceremonial"
    case SnowfallButterfiles = "Snowfall"
    case creepy = "creepy"
    case flip1 = "flip1"
    case flip2 = "flip2"
    case flop = "flop"
    case gameOver = "gameOver"
    case match = "match"
    case matchIgnite = "matchIgnite"
    case victory = "victory"
    case buttonPress = "buttonPress"
    case tinyButtonPress = "tinyButtonPress"
}

enum AudioTypeKey: String {
    case wav = "wav"
    case mp3 = "mp3"
}

enum AudioKey: String {
    case isMuted = "isMuted"
    case volumeLevel = "volumeLevel"
}

enum ColorKey: String {
    case myColor = "myColor"
}
