//
//  Properties.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

let gameInterface = GameInterface()

struct Properties {
    
    static let defaults = UserDefaults.standard
    
    ///cards FontSize and Color:
    static var debugFontSize: CGFloat = 0
    static var debugFontColor: UIColor = UIColor.white
    
    ///game over statistics helping lines:
    static var debugGameOverStatisticsViewAlpha: CGFloat = 0.0
    
    ///UI Color:
    static var uiLabelsColor = UIColor.black
    static var uiLabelsSize: CGFloat = 23
    static var uiLabelsFont = FontKey.staatliches.rawValue
    
    ///cards cover:
    static var cardCoverImage = UIImage(named: FigmaKey.cardCover3.rawValue)
    
    ///Admin Functions:
    static var hideAdminButtons = true
    
    ///debug Game Over:
    static var gameIsOver = false
    
    ///debug background Music:
    static var muteBackgroundMusic = false
    
    ///unlock price:
    static var unlockPriceGlobal: Int = 100
    
    ///Coins:
    static var coins = defaults.integer(forKey: CoinsKey.coins.rawValue)
    
    ///Card View Configuration:
    static var rows = 3
    static var columns = 2
    
    ///CollectionView InfoButton message:
    static let infoMessage = "Game Version: ver 0.5 (stable build) \n Unlock items in Collections Shop! \n Collect 🪙 coins in Game Mode \n 10 match pairs = 1 coin \n New Game Modes coming soon!"
    
    ///CollectionView list:
    static let listOfSets = ["Food",
                             "Animals",
                             "Music",
                             "Space",
                             "Flowers",
                             "Art",
                             "Canada",
                             "Ukraine"
    ]
    
    static var tutorialList = [String]()
    static var tutorialCompleted = defaults.bool(forKey: "tutorialCompleted")
    
    ///Shop unlocked list:
    static var cardSet1isUnlocked = defaults.bool(forKey: "cardSet1isUnlocked")
    static var cardSet2isUnlocked = defaults.bool(forKey: "cardSet2isUnlocked")
    
    static var coverSet1isUnlocked = defaults.bool(forKey: "coverSet1isUnlocked")
    static var coverSet2isUnlocked = defaults.bool(forKey: "coverSet2isUnlocked")
    
    static var cardSet1isSelected = false
    static var cardSet2isSelected = false
    
    static var coverSet1isSelected = false
    static var coverSet2isSelected = false
    
    ///Large Title in CollectionView
    static public var selectedSetName = String()
    
    ///"Selected" toolbar button in CardListController
    static var cardSetIsSelected = false
    
    ///Selected Collection from "Selected" Button in CardListController
    static var selectedCollection = [String]()

    ///Setup Selected Cards (Check if have Set1...6 in GameController
    static var selectedCardList = String()
    static var selectedCardListNumber = 0
    
    ///statistics block:
    static var selectedDifficulty = "Easy"
    static var standardTimeCounter = 180
    static var statisticsPairsCounter = 0
    static var statisticsFlipsCounter = 0
    static var statisticsScoreCounter = "D"
    
    ///collection settings unlock:
    static var unlockedList = [Bool]()
    static var selectedList = [Bool]()
    
    ///LockerModel:
    static var collectionOfLockedSets = [LockerModel]()
    
    ///Card Collections:
    static var cardCollection = [[String]]()

    ///Game Mechanics:
    static var cardCounter = 0
    static var cardButtons = [UIButton]()
    static var activatedButtons = [UIButton]()
    static var activatedCards = [String]()
    static var pairList = [String]()
    
    ///Timer and Pause:
    var timer: Timer!
    var isPaused = false
    
    ///Animations timing block:
    var flipAnimationTime =         0.4
    var flipBackAnimationTime =     0.4
    var timeToShowBothCards =       0.7
    var syncDisableAnimation: Double {
        flipBackAnimationTime + timeToShowBothCards
    }

    ///Settings Buttons:
    static var musicMutedSwitcher = true
    static var soundMutedSwitcher = true
    static var vibrationMutedSwitcher = true
        
    static var defaultMusicButtonLabel =        defaults.string(forKey: AudioKey.defaultMusicButtonLabel.rawValue) ?? "ON"
    static var defaultSoundButtonLabel =        defaults.string(forKey: AudioKey.defaultSoundButtonLabel.rawValue) ?? "ON"
    static var defaultVibrationButtonLabel =    defaults.string(forKey: AudioKey.defaultVibrationButtonLabel.rawValue) ?? "ON"
    
    ///Settings buttons color:
    static let defaultMusicButtonColor = defaults.colorForKey(key: ColorKey.musicButton.rawValue) ?? UIColor.green
    static let defaultSoundButtonColor = defaults.colorForKey(key: ColorKey.soundButton.rawValue) ?? UIColor.green
    static let defaultVibroButtonColor = defaults.colorForKey(key: ColorKey.vibrationButton.rawValue) ?? UIColor.green
}


