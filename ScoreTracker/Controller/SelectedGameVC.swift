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
    @IBOutlet weak var scoreLabelOne: UILabel!
    @IBOutlet weak var scoreLabelTwo: UILabel!
    @IBOutlet weak var winnngPercentageLabelOne: UILabel!
    @IBOutlet weak var winningPercentageLabelTwo: UILabel!
    @IBOutlet var drawLabel: UILabel!
    @IBOutlet var drawPercentageLabel: UILabel!
    @IBOutlet weak var currentChampionLabel: UILabel!
    @IBOutlet weak var totalGamesPlayedLabel: UILabel!
    @IBOutlet weak var lastWinnerLabel: UILabel!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    // Constants
    
    //Variables
    var chosenGameName: String?
    var opponentsName: String? {
        didSet {
            //saveItems()
        }
    }
  
    
    //MARK:- Views loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
//        let parallaxing = ParallaxEffect()
//        parallaxing.setUpParallax(background: backgroundOutlet)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        navigationItem.title = chosenGameName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    //MARK:- Set up game labels and buttons functions
    func setLabels() {
        scoreLabelOne.text = "\(nickName): \n\(Int(scoreOne))"
        scoreLabelTwo.text = "\(opponentsName!): \n\(Int(scoreTwo))"
        drawLabel.text = "Draws: \(Int(draws))"
        winnngPercentageLabelOne.text = "Winning Percentage: \n\(Int(scoreOneWinPercentage))%"
        winningPercentageLabelTwo.text = "Winning percentage: \n\(Int(scoreTwoWinPercentage))%"
        drawPercentageLabel.text = "Draw Percentage: \(Int(drawPercentage))%"
        currentChampionLabel.text = "Current Champion: \(currentChampion)"
        totalGamesPlayedLabel.text = "Games Played: \(Int(totalGamesPlayed))"
        lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        gameNameLabel.text = "\(chosenGameName!)"
        
    }
    
    //MARK:- Set up tapGuestures
    @objc func handleTap() {
        if navigationController?.navigationBar.isHidden == true {
        navigationController?.setNavigationBarHidden(false, animated: true)
            gameNameLabel.isHidden = true
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
            gameNameLabel.isHidden = false
        }
    }
    
    //MARK:- IBActions/Button pressed

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_WHO_WON_VC {
            let destinationVC = segue.destination as! WhoWonVC
                destinationVC.opponentsName = self.opponentsName
            
        }
    }
    
    @IBAction func addNewVictoryButton(_ sender: UIButton) {
            performSegue(withIdentifier: GO_TO_WHO_WON_VC, sender: self)
    }
    
    @IBAction func unwindToSelectedGameVC(_ sender: UIStoryboardSegue) {}
    
}


