//
//  Properties.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/4.
//

import UIKit

let UI = UserInterface()

struct Properties {
    
//    var cardList = [
//        "Bat", "Bat",
//        "Bones", "Bones",
//        "Cauldron", "Cauldron",
//        "Skull", "Skull",
//        "Ghost",  "Ghost",
//        "Pumpkin", "Pumpkin",
//        "Eye", "Eye",
//        "Dracula", "Dracula",
//        "Spider", "Spider",
//        "Cobweb", "Cobweb"
//    ]
    
//    var cardList = [
//                "egg", "egg",
//                "location", "location",
//                "pig", "pig",
//                "pikachu", "pikachu",
//                "pokeballs1", "pokeballs1",
//                "pokeballs2", "pokeballs2",
//                "pokeballs3", "pokeballs3",
//                "pokeballs4", "pokeballs4",
//                "pokemon-trainer", "pokemon-trainer",
//                "psyduck", "psyduck"
//            ]
    
    var cardList = [
        "argentina","argentina",
        "canada","canada",
        "HK","HK",
        "nz1","nz1",
        "nz2","nz2",
        "nz3","nz3",
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
    
    var flipAnimationTime = 0.4
    var flipBackAnimationTime = 0.4
    var timeToShowBothCards = 1.0
    
    var syncDisableAnimation: Double {
        flipBackAnimationTime + timeToShowBothCards
    }
    
    var userInterfaceFontSize: CGFloat = 0
    
    var debugFontSize: CGFloat = 20
    var debugFontColor: UIColor = UIColor.white
    
    
}


