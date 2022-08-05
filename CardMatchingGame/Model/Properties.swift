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
        "Bat", "Bat",
        "Bones", "Bones",
        "Cauldron", "Cauldron",
        "Skull", "Skull",
        "Ghost",  "Ghost",
        "Pumpkin", "Pumpkin",
        "Eye", "Eye",
        "Dracula", "Dracula",
        "Spider", "Spider",
        "Cobweb", "Cobweb"
    ]

    var cardButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var activatedCards = [String]()
    var pairList = [String]()
    var mutedGeneral = Bool()
    
    var syncDisableAnimation = 0.0
    var cardCounter = 0
    var timer: Timer!
}


