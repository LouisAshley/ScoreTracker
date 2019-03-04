//
//  WhoWonVC.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 02/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit


class WhoWonVC: UIViewController {
    
    //MARK:- Variables, Constants & Outlets
    //Outlets
    @IBOutlet weak var backgroundImageOutlet: UIImageView!
    
    // Variables
    var buttonPressedTag: Int = 0
    
    // Constants
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parallaxingEffect = ParallaxEffect()
        parallaxingEffect.setUpParallax(background: backgroundImageOutlet)
    }
    
    
    //MARK:- Segueways functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SelectedGameVC
        switch buttonPressedTag {
        case 2:
            destinationVC.lastWinner = "Dale"
            destinationVC.totalGamesPlayed += 1
            destinationVC.dalesScore += 1
            daleWonButtonDress(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
        case 3:
            destinationVC.lastWinner = "Lewis"
            destinationVC.totalGamesPlayed += 1
            destinationVC.lewisScore += 1
            lewisWonButtonPressed(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
        case 4:
            destinationVC.lastWinner = "Draw"
            destinationVC.totalGamesPlayed += 1
            destinationVC.draw += 1
            daleWonButtonDress(destination: destinationVC)
            lewisWonButtonPressed(destination: destinationVC)
            drawButtonPressed(destination: destinationVC)
        default:
            return
        }
        
    }
    
    
    //MARK:- functions to work out the scores
    func lewisWonButtonPressed(destination: SelectedGameVC) {
        let calculatePercentageLewis = PertentageCalc(daleScore: destination.dalesScore, lewisScore: destination.lewisScore, totalGames: destination.totalGamesPlayed).calculatePercentage()
        (destination.daleWinPercentage, destination.lewisWinPercentage) = calculatePercentageLewis
        if destination.lewisScore > destination.dalesScore {
            destination.currentChampion = "Lewis"
        } else if destination.lewisScore == destination.dalesScore {
            destination.currentChampion = "Draw"
        }
        
    }
    
    func daleWonButtonDress(destination: SelectedGameVC) {
        let calculatePercentageDale = PertentageCalc(daleScore: destination.dalesScore, lewisScore: destination.lewisScore, totalGames: destination.totalGamesPlayed).calculatePercentage()
        (destination.daleWinPercentage, destination.lewisWinPercentage) = calculatePercentageDale
        if destination.dalesScore > destination.lewisScore {
            destination.currentChampion = "Dale"
        } else if destination.dalesScore == destination.lewisScore {
            destination.currentChampion = "Draw"
        }
        
    }
    
    func drawButtonPressed(destination: SelectedGameVC) {
        let drawPercentage = destination.lewisWinPercentage + destination.daleWinPercentage - 100
        destination.drawPercentage = abs(drawPercentage)
        
    }
    
    
    //MARK:- IBActions/button pressed
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
    
    
    
    
    
}
