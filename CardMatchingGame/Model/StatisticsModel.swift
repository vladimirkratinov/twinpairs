//
//  StatisticsModel.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022-10-07.
//

import Foundation

struct StatisticsModel: Codable {
    var time: Int
    var difficulty: String
    var pairs: Int
    var flips: Int
    var score: String
}

struct BestResult: Codable {
    var time: Int
    var difficulty: String
    var pairs: Int
    var flips: Int
    var score: String
}
