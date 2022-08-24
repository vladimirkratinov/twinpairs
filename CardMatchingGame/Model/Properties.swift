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
    static var uiLabelsColor = UIColor.white
    
    //Card View Configuration:
    static var rows = 3
    static var columns = 2
    
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
    //Setup Selected Cards (Check if have Set1...6 in GameController        (??? CAN CHANGE)
    static var selectedCardList = String()
    
    //collection settings unlock:
    static var unlockedList = [Bool]()
    //LockerModel:
    static var collectionOfLockedSets = [LockerModel]()
    
    //Card Collections:
    static var cardCollection = [[String]]()
    static var cardList1 = [String]()
    static var cardList2 = [String]()
    static var cardList3 = [String]()
    static var cardList4 = [String]()
    static var cardList5 = [String]()
    static var cardList6 = [String]()

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
    var gameIsOver = false
    
    var flipAnimationTime = 0.4
    var flipBackAnimationTime = 0.4
    var timeToShowBothCards = 1.0
    
    var syncDisableAnimation: Double {
        flipBackAnimationTime + timeToShowBothCards
    }
    
    var userInterfaceFontSize: CGFloat = 10
}


