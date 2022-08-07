//
//  Properties.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

let UI = UserInterface()

struct Properties {
    
    var cardList = [
        "argentina","argentina",
        "canada","canada",
        "HK","HK",
        "japan","japan",
        "nz2","nz2",
        "knie","knie",
        "papua","papua",
        "US","US",
        "UK","UK",
        "USSR","USSR",
    ]

    var cardButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var activatedCards = [String]()
    var pairList = [String]()
    var lowerAmmountOfCardsList = [String]()
    
    var mutedGeneral = Bool()
    
    var timer: Timer!
    
    var cardCounter = 0
    var totalTime = 0
    var standardTimeCounter = 120
    var gameIsOver = false
    
    var rows = 3
    var columns = 2
    
    var flipAnimationTime = 0.4
    var flipBackAnimationTime = 0.4
    var timeToShowBothCards = 1.0
    
    var syncDisableAnimation: Double {
        flipBackAnimationTime + timeToShowBothCards
    }
    
    var userInterfaceFontSize: CGFloat = 0
    
    //cards FontSize and Color:
    var debugFontSize: CGFloat = 0
    var debugFontColor: UIColor = UIColor.white
    
    
}


