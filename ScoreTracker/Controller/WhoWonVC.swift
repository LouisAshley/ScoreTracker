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
        let selectedGameVC = segue.destination as! SelectedGameVC
        switch buttonPressedTag {
        case 2:
            selectedGameVC.scoreOne += 1
            selectedGameVC.lastWinner = "Player One"
            selectedGameVC.totalGamesPlayed += 1
            playerOneButtonPressed(destinationVC: selectedGameVC)
            drawButtonPressed(destinationVC: selectedGameVC)
        case 3:
            selectedGameVC.scoreTwo += 1
            selectedGameVC.lastWinner = "Player Two"
            selectedGameVC.totalGamesPlayed += 1
            playerTwoButtonPressed(destinationVC: selectedGameVC)
            drawButtonPressed(destinationVC: selectedGameVC)
            
        case 4:
            selectedGameVC.lastWinner = "Draw"
            selectedGameVC.totalGamesPlayed += 1
            selectedGameVC.draw += 1
            playerOneButtonPressed(destinationVC: selectedGameVC)
            playerTwoButtonPressed(destinationVC: selectedGameVC)
        default:
            return
        }
        
    }
    
    
    //MARK:- functions to work out the percentages and scores
    func playerOneButtonPressed(destinationVC: SelectedGameVC) {
        let calculateScoreOnePercentage = PertentageCalc(scoreOne: destinationVC.scoreOne, scoreTwo: destinationVC.scoreTwo, totalGames: destinationVC.totalGamesPlayed).calculatePercentage()
        (destinationVC.winPercentageOne, destinationVC.winPercentageTwo) = calculateScoreOnePercentage
        if destinationVC.scoreOne > destinationVC.scoreTwo {
            destinationVC.currentChampion = "Player One"
        } else if destinationVC.scoreOne == destinationVC.scoreTwo {
            destinationVC.currentChampion = "Draw"
        }
        
    }
    
    func playerTwoButtonPressed(destinationVC: SelectedGameVC) {
        let calculateScoreTwoPercentage = PertentageCalc(scoreOne: destinationVC.scoreOne, scoreTwo: destinationVC.scoreTwo, totalGames: destinationVC.totalGamesPlayed).calculatePercentage()
        (destinationVC.winPercentageOne, destinationVC.winPercentageTwo) = calculateScoreTwoPercentage
        if destinationVC.scoreTwo > destinationVC.scoreOne {
            destinationVC.currentChampion = "Player Two"
        } else if destinationVC.scoreTwo ==  destinationVC.scoreOne {
            destinationVC.currentChampion = "Draw"
        }
    }
    
    func drawButtonPressed(destinationVC: SelectedGameVC) {
        let drawPercentage = destinationVC.scoreOne + destinationVC.scoreTwo - 100
        destinationVC.drawPercentage = abs(drawPercentage)
        
    }
    
    
    //MARK:- IBActions/button pressed
    @IBAction func playerOneButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    @IBAction func playerTwoButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        
    }
    
    
    
    
}
