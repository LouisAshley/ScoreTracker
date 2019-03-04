//
//  matches.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation
import Firebase

class Matches {
    
    let ref = Database.database().reference(withPath: "matchesData")
    
    var dalesScore = 0.0
    var lewisScore = 0.0
    var currentChampion = ""
    var totalGamesPlayed = 0.0
    var dalesWinPercentage = 0.0
    var lewisWinPercentage = 0.0
    var draw = 0.0
    var drawPercentage = 0.0
    var lastWinner = ""
    
    
}


