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
    
    //cards FontSize and Color:
    var debugFontSize: CGFloat = 0
    var debugFontColor: UIColor = UIColor.white
    //UI Color:
    static var uiLabelsColor = UIColor.black
    static var uiLabelsSize: CGFloat = 23
    static var uiLabelsFont = FontKey.staatliches.rawValue
    //Admin Functions:
    static var hideAdminButtons = false
    //debug gameOver:
    static var gameIsOver = false
    //turn off music:
    static var generalBackgroundSoundIsMutedForTestPurposes = false
    
    //Coins:
    static var coins = defaults.integer(forKey: CoinsKey.coins.rawValue)
    //Card View Configuration:
    static var rows = 3
    static var columns = 2
    
    //background switcher state:
    static var backgroundGradientSwitcher = 1
    
    //CollectionView InfoButton message:
    static let infoMessage = "Game Version: ver 0.5 (stable build) \n Unlock items in Collections Shop! \n Collect 🪙 coins in Game Mode \n 10 match pairs = 1 coin \n New Game Modes coming soon!"
    
    //CollectionView list:
    static let listOfSets = ["Standart",
                             "New Zealand",
                             "Australia",
                             "Japan 1961 Flowers",
                             "Ukraine 1",
                             "Ukraine 2",
    ]
    
    //Large Title in CollectionView
    static public var selectedSetName = String()
    
    //"Selected" toolbar button in CardListController
    static var cardSetIsSelected = false
    
    //Selected Collection from "Selected" Button in CardListController
    static var selectedCollection = [String]()
    

    //Setup Selected Cards (Check if have Set1...6 in GameController
    static var selectedCardList = String()
    static var selectedCardListNumber = 0
    
    //select difficulty leve:
    static var selectedDifficulty = "Easy"
    
    //collection settings unlock:
    static var unlockedList = [Bool]()
    //LockerModel:
    static var collectionOfLockedSets = [LockerModel]()
    
    //Card Collections:
    static var cardCollection = [[String]]()

    //Game Mechanics
    static var cardButtons = [UIButton]()
    static var activatedButtons = [UIButton]()
    static var activatedCards = [String]()
    static var pairList = [String]()

    //Settings Buttons:
    static var musicMutedSwitcher = true
    static var soundMutedSwitcher = true
    static var vibrationMutedSwitcher = true
    
    //Timer and pause:
    var timer: Timer!
    var isPaused = false
    
    var cardCounter = 0
    var totalTime = 0
    var standardTimeCounter = 180
    
    var flipAnimationTime = 0.4
    var flipBackAnimationTime = 0.4
    var timeToShowBothCards = 1.0
    
    var hardcoreReduceTime = 0.5
    
    var syncDisableAnimation: Double {
        flipBackAnimationTime + timeToShowBothCards
    }
    
    var userInterfaceFontSize: CGFloat = 10
    
    //COLORS:
    static let defaultMusicButtonColor = defaults.colorForKey(key: ColorKey.musicButton.rawValue) ?? UIColor.systemPink
    static let defaultSoundButtonColor = defaults.colorForKey(key: ColorKey.soundButton.rawValue) ?? UIColor.systemPink
    static let defaultVibroButtonColor = defaults.colorForKey(key: ColorKey.vibrationButton.rawValue) ?? UIColor.systemPink
}


