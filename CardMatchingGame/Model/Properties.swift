//
//  Properties.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

let gameInterface = GameInterface()

struct Properties {
    
    //cards FontSize and Color:
    var debugFontSize: CGFloat = 0
    var debugFontColor: UIColor = UIColor.white
    
    static var uiLabelsColor = UIColor.white
    
    static var rows = 3
    static var columns = 2
    
    static let listOfSets = ["Standart",
                             "New Zealand",
                             "Australia",
                             "Japan 1961 Flowers",
                             "Ukraine 1",
                             "Ukraine 2",
    ]
    static public var selectedSetName = String()
    
    static var selectedCollection = [String]()
    static var selectedCardList = String()
    
    static var cardCollection = [[String]]()
    static var cardList1 = [String]()
    static var cardList2 = [String]()
    static var cardList3 = [String]()
    static var cardList4 = [String]()
    static var cardList5 = [String]()
    static var cardList6 = [String]()
    
    static var cardSetIsSelected = false
    
    static var collectionIsLocked = true
    
    static var cardListImage1 = [UIImage]()

    static var cardButtons = [UIButton]()
    static var activatedButtons = [UIButton]()
    
    static var activatedCards = [String]()
    static var pairList = [String]()
    static var lowerAmmountOfCardsList = [String]()
    
    static let defaults = UserDefaults.standard
    
    static var musicMutedSwitcher = true
    static var soundMutedSwitcher = true
    static var vibrationMutedSwitcher = true
    
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


