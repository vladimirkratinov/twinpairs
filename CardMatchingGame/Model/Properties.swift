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
    
    var rows = 3
    var columns = 2
    
    var cardCollection = [[String]]()
    
    var cardList = [
        "nz2","nz2",
        "argentina","argentina",
        "HK","HK",
        "japan","japan",
        "knie","knie",
        "papua","papua",
        "US","US",
        "UK","UK",
        "canada","canada",
        "USSR","USSR",
    ]
    
    var cardList1 = [
        "Pumpkin","Pumpkin",
        "CardBack","CardBack",
        "Bat","Bat",
        "Bones","Bones",
        "Cobweb","Cobweb",
        "Dracula","Dracula",
        "Eye","Eye",
        "Ghost","Ghost",
        "Skull","Skull",
        "Spider","Spider",
    ]
    
    var cardList2 = [
        "psyduck","psyduck",
        "CardBackSide1","CardBackSide1",
        "CardBackSide2","CardBackSide2",
        "egg","egg",
        "location","location",
        "pig","pig",
        "pikachu","pikachu",
        "pokeballs1","pokeballs1",
        "pokeballs2","pokeballs2",
        "pokeballs3","pokeballs3",
    ]

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


