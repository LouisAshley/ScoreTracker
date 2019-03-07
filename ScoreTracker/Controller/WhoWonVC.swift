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
    @IBOutlet weak var whoWonLabel: UILabel!
    @IBOutlet weak var playerOneWonLabel: UIButton!
    @IBOutlet weak var playerTwoWonLabel: UIButton!
    @IBOutlet weak var drawButtonLabel: UIButton!
    
    // Constants
    
    // Variables
    var opponentsName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        //        let parallaxingEffect = ParallaxEffect()
        //        parallaxingEffect.setUpParallax(background: backgroundImageOutlet)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        navigationItem.title = "Who Won?"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    //MARK:- Segueways functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let unwindDestination = segue.destination as! SelectedGameVC
        print("entered prepare")
        totalGamesPlayed += 1.0
        whatButtonWasPressed(sender: sender as! UIButton)
        unwindDestination.scoreLabelOne.text = "\(nickName): \n\(Int(scoreOne))"
        unwindDestination.scoreLabelTwo.text = "\(opponentsName!): \n\(Int(scoreTwo))"
        unwindDestination.winnngPercentageLabelOne.text = "Winning Percentage: \n\(Int(scoreOneWinPercentage))%"
        unwindDestination.winningPercentageLabelTwo.text = "Winning Percentage: \n\(Int(scoreTwoWinPercentage))%"
        unwindDestination.drawLabel.text = "Draws: \(Int(draws))"
        unwindDestination.drawPercentageLabel.text = "Draw Percentage: \(Int(drawsPercentage))%"
        unwindDestination.currentChampionLabel.text = "Current Champion: \(currentChampion)"
        unwindDestination.lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        unwindDestination.totalGamesPlayedLabel.text = "Games Played: \(Int(totalGamesPlayed))"
    }
    
    
    //MARK:- functions
 
    func setLabels() {
        playerOneWonLabel.setTitle(nickName, for: .normal)
        playerTwoWonLabel.setTitle("\(opponentsName!)", for: .normal)
        drawButtonLabel.setTitle("Draw", for: .normal)
    }
    
    //MARK:- Add tap gestures to the display
    @objc func handleTap() {
        if navigationController?.navigationBar.isHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: true)
            whoWonLabel.isHidden = true
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
            whoWonLabel.isHidden = false
        }
    }
    
    func whatButtonWasPressed(sender: UIButton) {
        switch sender.tag {
        case 2:
        playerOneAddStats()
        case 3:
        playerTwoAddStats()
        case 4:
        drawAddStats()
        default:
        return
        }
    }
    
    func playerOneAddStats() {
        scoreOne += 1
        lastWinner = nickName
        let calculateScoreOnePercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateScoreOnePercentage
        
        if scoreOne > scoreTwo {
            currentChampion = nickName
        } else if scoreOne == scoreTwo {
            currentChampion = "Draw"
        }
    }
    
    func playerTwoAddStats() {
        scoreTwo += 1
        lastWinner = "\(opponentsName!)"
        let calculateScoreTwoPercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateScoreTwoPercentage
        if scoreTwo > scoreOne {
            currentChampion = opponentsName!
        } else if scoreTwo ==  scoreOne {
            currentChampion = "Draw"
        }
    }
    
    func drawAddStats() {
        draws += 1
        lastWinner = "Draw"
        let calculateDraws = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateDraws
    }
    
    
    //MARK:- IBActions/button pressed
    @IBAction func playerOneButton(_ sender: UIButton) {
    
    }
    
    @IBAction func playerTwoButton(_ sender: UIButton) {
        
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        
    }
    
    
    
    
}
