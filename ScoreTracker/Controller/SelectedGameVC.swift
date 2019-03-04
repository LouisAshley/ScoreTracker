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
    @IBOutlet weak var daleScoreLabel: UILabel!
    @IBOutlet weak var lewisScoreLabel: UILabel!
    @IBOutlet weak var daleWinnngPercentageLabel: UILabel!
    @IBOutlet weak var lewisWinningPercentageLabel: UILabel!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    @IBOutlet weak var lastWinnerLabel: UILabel!
    @IBOutlet var drawLabel: UILabel!
    @IBOutlet var drawPercentageLabel: UILabel!
    
    
    // Variables
    var dalesScore = 0.0
    var lewisScore = 0.0
    var totalGamesPlayed = 0.0
    var currentChampion = ""
    var daleWinPercentage = 0.0
    var lewisWinPercentage = 0.0
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
        daleWinnngPercentageLabel.text = "Winning Percentage: \n\(Int(daleWinPercentage))%"
        lewisWinningPercentageLabel.text = "Winning percentage: \n\(Int(lewisWinPercentage))%"
        drawPercentageLabel.text = "Draw Percentage: \(Int(drawPercentage))%"
        daleScoreLabel.text = "Dale: \n\(Int(dalesScore))"
        lewisScoreLabel.text = "Lewis: \n\(Int(lewisScore))"
        drawLabel.text = "Draws: \(Int(draw))"
        currentChampionLabel.text = "Current Champion: \(currentChampion)"
        totalGamesPlayedLabel.text = "Games Played: \(Int(totalGamesPlayed))"
        lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        
    }
    
    func defaultValuesButtonPressed() {
        dalesScore = DefaultValues().dalesScore
        lewisScore = DefaultValues().lewisScore
        totalGamesPlayed = DefaultValues().totalGamesPlayed
        currentChampion = DefaultValues().currentChampion
        daleWinPercentage = DefaultValues().dalesWinPercentage
        lewisWinPercentage = DefaultValues().lewisWinPercentage
        draw = DefaultValues().draw
        drawPercentage = DefaultValues().drawPercentage
        lastWinner = DefaultValues().lastWinner
    }
    
    
    //MARK:- IBActions/Button pressed
    @IBAction func addNewVictoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "whoWonSegue", sender: self)
        
    }
    
    @IBAction func unwindToMainScreenVC(_ sender: UIStoryboardSegue) {}
    
    @IBAction func restartScores(_ sender: UIButton) {
        defaultValuesButtonPressed()
        setLabels()
        print("I was pressed to restart")
        
    }
    
    
    
}


