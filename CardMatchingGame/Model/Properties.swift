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
    
    var rows = 5
    var columns = 4
    
    var cardCollection = [[String]]()
    var cardList1 = [String]()
    var cardList2 = [String]()
    var cardList3 = [String]()
    
//    static var cardCollection = [[String]]()
//    static var cardList1 = [String]()
//    static var cardList2 = [String]()
//    static var cardList3 = [String]()

    var cardButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var activatedCards = [String]()
    var pairList = [String]()
    var lowerAmmountOfCardsList = [String]()
    
    var mutedGeneral = Bool()
    
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


