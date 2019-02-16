//
//  SaveInfo.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 10/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation


class SaveInfo {
    
   let defaults = UserDefaults.standard
    
    var daleScore: Double
    var lewisScore: Double
    var totalGamesPlayed: Double
    var currentChampion: String
    var daleWinPercentage: Double
    var lewisWinPercentage: Double
    var drawnGames: Double
    var drawPercentage: Double
    var lastWinner: String
    
    enum Keys: String {
        case daleScore = "dalesScore"
        case lewisScore = "lewisScore"
        case totalGamesPlayed = "totalGamesPlayed"
        case currentChampion = "currentChampion"
        case daleWinPercentage = "dalesWinPercentage"
        case lewisWinPercentage = "lewisWinPercentage"
        case drawnGames = "drawnGames"
        case drawPercentage = "drawPercentage"
        case lastWinner = "lastWinner"
        
    }
    
    init (daleScore: Double, lewisScore: Double, totalGamesPlayed: Double, currentChampion: String, daleWinPercentage: Double, lewisWinPercentage: Double, drawnGames: Double, drawPercentage: Double, lastWinner: String) {
        self.daleScore = daleScore
        self.lewisScore = lewisScore
        self.totalGamesPlayed = totalGamesPlayed
        self.currentChampion = currentChampion
        self.daleWinPercentage = daleWinPercentage
        self.lewisWinPercentage = lewisWinPercentage
        self.drawnGames = drawnGames
        self.drawPercentage = drawPercentage
        self.lastWinner = lastWinner
        
    }
    
    func saveScores() {
        defaults.set(daleScore, forKey: Keys.daleScore.rawValue)
        defaults.set(lewisScore, forKey: Keys.lewisScore.rawValue)
        defaults.set(totalGamesPlayed, forKey: Keys.totalGamesPlayed.rawValue)
        defaults.set(currentChampion, forKey: Keys.currentChampion.rawValue)
        defaults.set(daleWinPercentage, forKey: Keys.daleWinPercentage.rawValue)
        defaults.set(lewisWinPercentage, forKey: Keys.lewisWinPercentage.rawValue)
        defaults.set(drawnGames, forKey: Keys.drawnGames.rawValue)
        defaults.set(drawPercentage, forKey: Keys.drawPercentage.rawValue)
        defaults.set(lastWinner, forKey: Keys.lastWinner.rawValue)
        
    }
    
    func getScores() -> (daleScore: Double, lewisScore: Double, totalGamesPlayed: Double, currentChampion: String, daleWinPercentage: Double, lewisWinPercentage: Double, drawnGames: Double, drawPercentage: Double, lastWinner: String) {
        
        let dalesScoreSave = defaults.value(forKey: Keys.daleScore.rawValue) as? Double
        let lewisScoreSave = defaults.value(forKey: Keys.lewisScore.rawValue) as? Double
        let totalGamesPlayedSave = defaults.value(forKey: Keys.totalGamesPlayed.rawValue) as? Double
        let currentChampionSave = defaults.value(forKey: Keys.currentChampion.rawValue) as? String
        let daleWinPercentageSave = defaults.value(forKey: Keys.daleWinPercentage.rawValue) as? Double
        let lewisWinPercentageSave = defaults.value(forKey: Keys.lewisWinPercentage.rawValue ) as? Double
        let drawnGamesSave = defaults.value(forKey: Keys.drawnGames.rawValue) as? Double
        let drawPercentageSave = defaults.value(forKey: Keys.drawPercentage.rawValue) as? Double
        let lastWinnerSave = defaults.value(forKey: Keys.lastWinner.rawValue) as? String
        
        daleScore = dalesScoreSave ?? 0
        lewisScore = lewisScoreSave ?? 0
        totalGamesPlayed = totalGamesPlayedSave ?? 0
        currentChampion = currentChampionSave ?? ""
        daleWinPercentage = daleWinPercentageSave ?? 0
        lewisWinPercentage = lewisWinPercentageSave ?? 0
        drawnGames = drawnGamesSave ?? 0
        drawPercentage = drawPercentageSave ?? 0
        lastWinner = lastWinnerSave ?? ""
        
        return (daleScore, lewisScore, totalGamesPlayed, currentChampion, daleWinPercentage, lewisWinPercentage, drawnGames, drawPercentage, lastWinner)
    }
    
    
}
