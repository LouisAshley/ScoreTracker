//
//  ViewController.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 02/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit

class SelectedGameVC: UIViewController {
    
    //Mark:- Variables, Constants & Outlets
    
    // Outlets
    @IBOutlet weak var currentChampionLabel: UILabel!
    @IBOutlet weak var totalGamesPlayedLabel: UILabel!
    @IBOutlet weak var scoreLabelOne: UILabel!
    @IBOutlet weak var scoreLabelTwo: UILabel!
    @IBOutlet weak var winnngPercentageLabelOne: UILabel!
    @IBOutlet weak var winningPercentageLabelTwo: UILabel!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    @IBOutlet weak var lastWinnerLabel: UILabel!
    @IBOutlet var drawLabel: UILabel!
    @IBOutlet var drawPercentageLabel: UILabel!
    
    
    // Variables
    var scoreOne = 0.0
    var scoreTwo = 0.0
    var totalGamesPlayed = 0.0
    var currentChampion = ""
    var winPercentageOne = 0.0
    var winPercentageTwo = 0.0
    var lastWinner = ""
    var draw = 0.0
    var drawPercentage = 0.0
    
    
    //MARK:- Views loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        let parallaxing = ParallaxEffect()
        parallaxing.setUpParallax(background: backgroundOutlet)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLabels()
        
    }
    
    //MARK:- Set up game labels and buttons functions
    func setLabels() {
        scoreLabelOne.text = "You: \n\(Int(scoreOne))"
        scoreLabelTwo.text = "Player Two: \n\(Int(scoreTwo))"
        drawLabel.text = "Draws: \(Int(draw))"
        winnngPercentageLabelOne.text = "Winning Percentage: \n\(Int(winPercentageOne))%"
        winningPercentageLabelTwo.text = "Winning percentage: \n\(Int(winPercentageTwo))%"
        drawPercentageLabel.text = "Draw Percentage: \(Int(drawPercentage))%"
        currentChampionLabel.text = "Current Champion: \(currentChampion)"
        totalGamesPlayedLabel.text = "Games Played: \(Int(totalGamesPlayed))"
        lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        
    }
    
    //MARK:- IBActions/Button pressed
    @IBAction func addNewVictoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "whoWonSegue", sender: self)
        
    }
    
    @IBAction func unwindToSelectedGameVC(_ sender: UIStoryboardSegue) {}
    
    
    
}


