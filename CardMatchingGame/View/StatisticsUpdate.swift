//
//  StatisticsUpdate.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022-10-07.
//

import Foundation

extension GameController {
    
    func updateStatistics() {
                
        var computedScore: String = "N/A"
        let pcounter = gameInterface.pairsCounter
        
        //Score computing:
        switch Properties.standardTimeCounter {
            
        case 180:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if pcounter >= 48 {
                    computedScore = "S+"
                } else if pcounter >= 40 {
                    computedScore = "S"
                } else if pcounter >= 30 {
                    computedScore = "A"
                } else if pcounter >= 20 {
                    computedScore = "B"
                } else if pcounter >= 10 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.medium.rawValue:
                
                if pcounter >= 35 {
                    computedScore = "S+"
                } else if pcounter >= 30 {
                    computedScore = "S"
                } else if pcounter >= 25 {
                    computedScore = "A"
                } else if pcounter >= 20 {
                    computedScore = "B"
                } else if pcounter >= 10 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.hard.rawValue:
                
                if pcounter >= 35 {
                    computedScore = "S+"
                } else if pcounter >= 30 {
                    computedScore = "S"
                } else if pcounter >= 25 {
                    computedScore = "A"
                } else if pcounter >= 20 {
                    computedScore = "B"
                } else if pcounter >= 10 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            default: return
                
            }
            
        case 300:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if pcounter >= 75 {
                    computedScore = "S+"
                } else if pcounter >= 60 {
                    computedScore = "S"
                } else if pcounter >= 45 {
                    computedScore = "A"
                } else if pcounter >= 30 {
                    computedScore = "B"
                } else if pcounter >= 15 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.medium.rawValue:
                
                if pcounter >= 60 {
                    computedScore = "S+"
                } else if pcounter >= 50 {
                    computedScore = "S"
                } else if pcounter >= 40 {
                    computedScore = "A"
                } else if pcounter >= 30 {
                    computedScore = "B"
                } else if pcounter >= 20 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.hard.rawValue:
                
                if pcounter >= 60 {
                    computedScore = "S+"
                } else if pcounter >= 50 {
                    computedScore = "S"
                } else if pcounter >= 40 {
                    computedScore = "A"
                } else if pcounter >= 30 {
                    computedScore = "B"
                } else if pcounter >= 20 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            default: return
                
            }
            
        case 600:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if pcounter >= 140 {
                    computedScore = "S+"
                } else if pcounter >= 120 {
                    computedScore = "S"
                } else if pcounter >= 100 {
                    computedScore = "A"
                } else if pcounter >= 80 {
                    computedScore = "B"
                } else if pcounter >= 40 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.medium.rawValue:
                
                if pcounter >= 120 {
                    computedScore = "S+"
                } else if pcounter >= 100 {
                    computedScore = "S"
                } else if pcounter >= 80 {
                    computedScore = "A"
                } else if pcounter >= 40 {
                    computedScore = "B"
                } else if pcounter >= 20 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            case DifficultyKey.hard.rawValue:
                
                if pcounter >= 120 {
                    computedScore = "S+"
                } else if pcounter >= 100 {
                    computedScore = "S"
                } else if pcounter >= 80 {
                    computedScore = "A"
                } else if pcounter >= 40 {
                    computedScore = "B"
                } else if pcounter >= 20 {
                    computedScore = "C"
                } else {
                    computedScore = "D"
                }
                
            default: return
                
            }
            
        default: return
            
        }
        
        let result = StatisticsModel(time: Properties.standardTimeCounter,
                                     difficulty: Properties.selectedDifficulty,
                                     pairs: gameInterface.pairsCounter,
                                     flips: gameInterface.flipsCounter,
                                     score: computedScore)
        
        //MARK: - 3 min:
        
        var best180Easy = BestResult(time: 180,
                                            difficulty: DifficultyKey.easy.rawValue,
                                            pairs: Properties.defaults.integer(forKey: StatisticsKey.Easy180Pairs.rawValue),
                                            flips: Properties.defaults.integer(forKey: StatisticsKey.Easy180Flips.rawValue),
                                            score: Properties.defaults.string(forKey:  StatisticsKey.Easy180Score.rawValue) ?? "N/A")
        
        var best180Medium = BestResult(time: 180,
                                              difficulty: DifficultyKey.medium.rawValue,
                                              pairs: Properties.defaults.integer(forKey: StatisticsKey.Medium180Pairs.rawValue),
                                              flips: Properties.defaults.integer(forKey: StatisticsKey.Medium180Flips.rawValue),
                                              score: Properties.defaults.string(forKey:  StatisticsKey.Medium180Score.rawValue) ?? "N/A")
        
        var best180Hard = BestResult(time: 180,
                                            difficulty: DifficultyKey.hard.rawValue,
                                            pairs: Properties.defaults.integer(forKey: StatisticsKey.Hard180Pairs.rawValue),
                                            flips: Properties.defaults.integer(forKey: StatisticsKey.Hard180Flips.rawValue),
                                            score: Properties.defaults.string(forKey:  StatisticsKey.Hard180Score.rawValue) ?? "N/A")
        
        //MARK: - 5 min:
        
        var best300Easy = BestResult(time: 300,
                                            difficulty: DifficultyKey.easy.rawValue,
                                            pairs: Properties.defaults.integer(forKey: StatisticsKey.Easy300Pairs.rawValue),
                                            flips: Properties.defaults.integer(forKey: StatisticsKey.Easy300Flips.rawValue),
                                            score: Properties.defaults.string(forKey:  StatisticsKey.Easy300Score.rawValue) ?? "N/A")
        
        var best300Medium = BestResult(time: 300,
                                              difficulty: DifficultyKey.medium.rawValue,
                                              pairs: Properties.defaults.integer(forKey: StatisticsKey.Medium300Pairs.rawValue),
                                              flips: Properties.defaults.integer(forKey: StatisticsKey.Medium300Flips.rawValue),
                                              score: Properties.defaults.string(forKey:  StatisticsKey.Medium300Score.rawValue) ?? "N/A")
        
        var best300Hard = BestResult(time: 300,
                                            difficulty: DifficultyKey.hard.rawValue,
                                            pairs: Properties.defaults.integer(forKey: StatisticsKey.Hard300Pairs.rawValue),
                                            flips: Properties.defaults.integer(forKey: StatisticsKey.Hard300Flips.rawValue),
                                            score: Properties.defaults.string(forKey:  StatisticsKey.Hard300Score.rawValue) ?? "N/A")
        
        //MARK: - 10 min:
        
        var best600Easy = BestResult(time: 600,
                                             difficulty: DifficultyKey.easy.rawValue,
                                             pairs: Properties.defaults.integer(forKey: StatisticsKey.Easy600Pairs.rawValue),
                                             flips: Properties.defaults.integer(forKey: StatisticsKey.Easy600Flips.rawValue),
                                             score: Properties.defaults.string(forKey:  StatisticsKey.Easy600Score.rawValue) ?? "N/A")
        
        var best600Medium = BestResult(time: 600,
                                               difficulty: DifficultyKey.medium.rawValue,
                                               pairs: Properties.defaults.integer(forKey: StatisticsKey.Medium600Pairs.rawValue),
                                               flips: Properties.defaults.integer(forKey: StatisticsKey.Medium600Flips.rawValue),
                                               score: Properties.defaults.string(forKey:  StatisticsKey.Medium600Score.rawValue) ?? "N/A")
        
        var best600Hard = BestResult(time: 600,
                                             difficulty: DifficultyKey.hard.rawValue,
                                             pairs: Properties.defaults.integer(forKey: StatisticsKey.Hard600Pairs.rawValue),
                                             flips: Properties.defaults.integer(forKey: StatisticsKey.Hard600Flips.rawValue),
                                             score: Properties.defaults.string(forKey:  StatisticsKey.Hard600Score.rawValue) ?? "N/A")
        
        //Set UserDefaults:
        switch Properties.standardTimeCounter {
            
        case 180:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if gameInterface.pairsCounter > best180Easy.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Easy180Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Easy180Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Easy180Score.rawValue)
                    
                    best180Easy.pairs = result.pairs
                    best180Easy.flips = result.flips
                    best180Easy.score = result.score
                    
                    print()
                    print("180-EASY RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best180Easy.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best180Easy.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best180Easy.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best180Easy.score)
                    }
                }
                
            case DifficultyKey.medium.rawValue:
                
                if gameInterface.pairsCounter > best180Medium.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Medium180Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Medium180Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Medium180Score.rawValue)
                    
                    best180Medium.pairs = result.pairs
                    best180Medium.flips = result.flips
                    best180Medium.score = result.score
                    
                    print()
                    print("180-MEDIUM RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best180Medium.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best180Medium.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best180Medium.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best180Medium.score)
                    }
                }
                
                
            case DifficultyKey.hard.rawValue:
                
                if gameInterface.pairsCounter > best180Hard.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Hard180Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Hard180Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Hard180Score.rawValue)
                    
                    best180Hard.pairs = result.pairs
                    best180Hard.flips = result.flips
                    best180Hard.score = result.score
                    
                    print()
                    print("180-HARD RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best180Hard.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best180Hard.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best180Hard.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best180Hard.score)
                    }
                }

            default: return
                
            }

        case 300:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if gameInterface.pairsCounter > best300Easy.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Easy300Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Easy300Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Easy300Score.rawValue)
                    
                    best300Easy.pairs = result.pairs
                    best300Easy.flips = result.flips
                    best300Easy.score = result.score
                    
                    print()
                    print("300-EASY RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best300Easy.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best300Easy.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best300Easy.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best300Easy.score)
                    }
                }
                
            case DifficultyKey.medium.rawValue:
                
                if gameInterface.pairsCounter > best300Medium.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Medium300Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Medium300Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Medium300Score.rawValue)
                    
                    best300Medium.pairs = result.pairs
                    best300Medium.flips = result.flips
                    best300Medium.score = result.score
                    
                    print()
                    print("300-MEDIUM RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best300Medium.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best300Medium.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best300Medium.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best300Medium.score)
                    }
                }
                
                
            case DifficultyKey.hard.rawValue:
                
                if gameInterface.pairsCounter > best300Hard.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Hard300Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Hard300Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Hard300Score.rawValue)
                    
                    best300Hard.pairs = result.pairs
                    best300Hard.flips = result.flips
                    best300Hard.score = result.score
                    
                    print()
                    print("300-HARD RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best300Hard.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best300Hard.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best300Hard.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best300Hard.score)
                    }
                }

            default: return
                
            }
            
        case 600:
            
            switch Properties.selectedDifficulty {
                
            case DifficultyKey.easy.rawValue:
                
                if gameInterface.pairsCounter > best600Easy.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Easy600Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Easy600Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Easy600Score.rawValue)
                    
                    best600Easy.pairs = result.pairs
                    best600Easy.flips = result.flips
                    best600Easy.score = result.score
                    
                    print()
                    print("600-EASY RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best600Easy.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best600Easy.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best600Easy.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best600Easy.score)
                    }
                }
                
            case DifficultyKey.medium.rawValue:
                
                if gameInterface.pairsCounter > best600Medium.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Medium600Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Medium600Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Medium600Score.rawValue)
                    
                    best600Medium.pairs = result.pairs
                    best600Medium.flips = result.flips
                    best600Medium.score = result.score
                    
                    print()
                    print("180-MEDIUM RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best600Medium.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best600Medium.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best600Medium.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best600Medium.score)
                    }
                }
                
                
            case DifficultyKey.hard.rawValue:
                
                if gameInterface.pairsCounter > best600Hard.pairs {
                    
                    Properties.defaults.set(result.pairs, forKey: StatisticsKey.Hard600Pairs.rawValue)
                    Properties.defaults.set(result.flips, forKey: StatisticsKey.Hard600Flips.rawValue)
                    Properties.defaults.set(result.score, forKey: StatisticsKey.Hard600Score.rawValue)
                    
                    best600Hard.pairs = result.pairs
                    best600Hard.flips = result.flips
                    best600Hard.score = result.score
                    
                    print()
                    print("600-HARD RESULTS ARE UPDATED!")
                    
                    //update UI:
                    DispatchQueue.main.async {
                        self.gameInterface.bestResultTimeViewLabel.text =  String(best600Hard.time)
                        self.gameInterface.bestResultFlipsViewLabel.text = String(best600Hard.flips)
                        self.gameInterface.bestResultPairsViewLabel.text = String(best600Hard.pairs)
                        self.gameInterface.bestResultScoreViewLabel.text = String(best600Hard.score)
                    }
                }

            default: return
                
            }
            
        default: return
            
        }

        //Update score label:
        DispatchQueue.main.async {
            self.gameInterface.yourResultTimeViewLabel.text =   String(Properties.standardTimeCounter)
            self.gameInterface.yourResultFlipsViewLabel.text =  String(self.gameInterface.flipsCounter)
            self.gameInterface.yourResultPairsViewLabel.text =  String(self.gameInterface.pairsCounter)
            self.gameInterface.yourResultScoreViewLabel.text =  String(result.score)
            
            switch Properties.standardTimeCounter {
                
            case 180:
                
                switch Properties.selectedDifficulty {
                    
                case DifficultyKey.easy.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best180Easy.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best180Easy.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best180Easy.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best180Easy.score)
                    
                case DifficultyKey.medium.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best180Medium.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best180Medium.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best180Medium.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best180Medium.score)
                    
                case DifficultyKey.hard.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best180Hard.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best180Hard.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best180Hard.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best180Hard.score)
                default: return
                }
                
            case 300:
                
                switch Properties.selectedDifficulty {
                    
                case DifficultyKey.easy.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best300Easy.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best300Easy.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best300Easy.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best300Easy.score)
                    
                case DifficultyKey.medium.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best300Medium.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best300Medium.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best300Medium.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best300Medium.score)
                    
                case DifficultyKey.hard.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best300Hard.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best300Hard.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best300Hard.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best300Hard.score)
                default: return
                }
                
            case 600:
                
                switch Properties.selectedDifficulty {
                    
                case DifficultyKey.easy.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best600Easy.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best600Easy.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best600Easy.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best600Easy.score)
                    
                case DifficultyKey.medium.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best600Medium.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best600Medium.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best600Medium.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best600Medium.score)
                    
                case DifficultyKey.hard.rawValue:
                    
                    self.gameInterface.bestResultTimeViewLabel.text =   String(best600Hard.time)
                    self.gameInterface.bestResultFlipsViewLabel.text =  String(best600Hard.flips)
                    self.gameInterface.bestResultPairsViewLabel.text =  String(best600Hard.pairs)
                    self.gameInterface.bestResultScoreViewLabel.text =  String(best600Hard.score)
                    
                default: return
                    
                }
            
            default: return
                
            }
            
        }
        
    }

}
