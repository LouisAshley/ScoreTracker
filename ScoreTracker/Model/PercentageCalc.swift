//
//  PercentageCalc.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 07/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation

class PertentageCalc {
    
    public private(set) var scoreOne: Double
    public private(set) var scoreTwo: Double
    public private(set) var totalGames: Double
    public private(set) var draws: Double
    
    
    init(scoreOne: Double, scoreTwo: Double, draws: Double, totalGames: Double) {
        self.scoreOne = scoreOne
        self.scoreTwo = scoreTwo
        self.totalGames = totalGames
        self.draws = draws
    }
    
    func calculatePercentage() -> (Double, Double, Double) {
        let scoreOnePercentage = (scoreOne / totalGames) * 100
        let scoreTwoPercentage = (scoreTwo / totalGames) * 100
        let drawPercentage = (draws / totalGames) * 100
        return (scoreOnePercentage, scoreTwoPercentage, drawPercentage)
    }
    
}
