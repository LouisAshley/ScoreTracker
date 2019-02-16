//
//  WhoWonVC.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 02/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit


class WhoWonVC: UIViewController {
    
    var buttonPressedTag: Int = 0
    
    @IBOutlet weak var backgroundImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parallaxingEffect = ParallaxEffect()
        parallaxingEffect.setUpParallax(background: backgroundImageOutlet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MainScreenVC
        switch buttonPressedTag {
        case 2:
            destinationVC.lastWinner = "Dale"
            destinationVC.totalGamesPlayed += 1
            destinationVC.dalesScore += 1
            daleWonButtonDress(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
            saveGameData(destination: destinationVC)
        case 3:
            destinationVC.lastWinner = "Lewis"
            destinationVC.totalGamesPlayed += 1
            destinationVC.lewisScore += 1
            lewisWonButtonPressed(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
            saveGameData(destination: destinationVC)
        case 4:
            destinationVC.lastWinner = "Draw"
            destinationVC.totalGamesPlayed += 1
            destinationVC.draw += 1
            daleWonButtonDress(destination: destinationVC)
            lewisWonButtonPressed(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
            saveGameData(destination: destinationVC)
        default:
            return
        }
        
    }
    
    func lewisWonButtonPressed(destination: MainScreenVC) {
        let calculatePercentageLewis = PertentageCalc(daleScore: destination.dalesScore, lewisScore: destination.lewisScore, totalGames: destination.totalGamesPlayed).calculatePercentage()
        (destination.daleWinPercentage, destination.lewisWinPercentage) = calculatePercentageLewis
        if destination.lewisScore > destination.dalesScore {
            destination.currentChampion = "Lewis"
        } else if destination.lewisScore == destination.dalesScore {
            destination.currentChampion = "Draw"
        }
        
    }
    
    func daleWonButtonDress(destination: MainScreenVC) {
        let calculatePercentageDale = PertentageCalc(daleScore: destination.dalesScore, lewisScore: destination.lewisScore, totalGames: destination.totalGamesPlayed).calculatePercentage()
        (destination.daleWinPercentage, destination.lewisWinPercentage) = calculatePercentageDale
        if destination.dalesScore > destination.lewisScore {
            destination.currentChampion = "Dale"
        } else if destination.dalesScore == destination.lewisScore {
            destination.currentChampion = "Draw"
        }
        
    }
    
    func saveGameData(destination: MainScreenVC) {
        let saveInfo =  SaveInfo(daleScore: destination.dalesScore, lewisScore: destination.lewisScore, totalGamesPlayed: destination.totalGamesPlayed, currentChampion: destination.currentChampion, daleWinPercentage: destination.daleWinPercentage, lewisWinPercentage: destination.lewisWinPercentage, drawnGames: destination.draw, drawPercentage: destination.drawPercentage, lastWinner: destination.lastWinner)
        saveInfo.saveScores()
        
    }
    
    
    @IBAction func lewisWonButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    @IBAction func daleWonButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    @IBAction func backButtonWhoWonVC(_ sender: Any) {
        
    }
    
    
    func drawButtonPressed(destination: MainScreenVC) {
        let drawPercentage = destination.lewisWinPercentage + destination.daleWinPercentage - 100
        destination.drawPercentage = abs(drawPercentage)
        
    }
    
    
}
