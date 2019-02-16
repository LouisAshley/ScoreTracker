//
//  PercentageCalc.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 07/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation

class PertentageCalc {
    
    public private(set) var daleScore: Double
    public private(set) var lewisScore: Double
    public private(set) var totalGames: Double
    
    init(daleScore: Double, lewisScore: Double, totalGames: Double) {
        self.daleScore = daleScore
        self.lewisScore = lewisScore
        self.totalGames = totalGames
    }
    
    func calculatePercentage() -> (Double, Double) {
        let dalePercentage = (self.daleScore / self.totalGames) * 100
        let lewisPercentage = (self.lewisScore / self.totalGames) * 100
        return (dalePercentage, lewisPercentage)
    }
    
}
