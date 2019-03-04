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
    
    init(scoreOne: Double, scoreTwo: Double, totalGames: Double) {
        self.scoreOne = scoreOne
        self.scoreTwo = scoreTwo
        self.totalGames = totalGames
    }
    
    func calculatePercentage() -> (Double, Double) {
        let scoreOnePercentage = (self.scoreOne / self.totalGames) * 100
        let scoreTwoPercentage = (self.scoreTwo / self.totalGames) * 100
        return (scoreOnePercentage, scoreTwoPercentage)
    }
    
}
