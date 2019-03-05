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
    var buttonPressedTag: Int = 0
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
    
    func prepare(for segue: UIStoryboardSegue, sender: UIButton?) {
        let unwindDestination = segue.destination as! SelectedGameVC
        
        switch buttonPressedTag {
        case 1:
            playerOneAddStats()
            print("Inside Case 1")
        case 2:
            playerTwoAddStats()
        case 3:
            drawAddStats()
        default:
            return
        }
        unwindDestination.scoreLabelOne.text = "\(nickName): \n\(Int(scoreOne))"
        unwindDestination.scoreLabelTwo.text = "\(opponentsName!): \n\(Int(scoreTwo))"
        unwindDestination.winnngPercentageLabelOne.text = "Winning Percentage: \n\(Int(scoreOneWinPercentage))"
        unwindDestination.winningPercentageLabelTwo.text = "Winning Percentage: \n\(Int(scoreTwoWinPercentage))"
        unwindDestination.drawLabel.text = "Draws: \(Int(draws))"
        unwindDestination.drawPercentageLabel.text = "Draw Percentage: \(Int(drawPercentage))"
        unwindDestination.currentChampionLabel.text = "Current Champion: \(currentChampion)"
        unwindDestination.lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        unwindDestination.totalGamesPlayedLabel.text = "Games Played: \(totalGamesPlayed)"
        print("finished updatng labels")
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performSegue(withIdentifier: UNWIND_TO_WHO_WON_VC, sender: self)
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
    
    func playerOneAddStats() {
        scoreOne += 1
        totalGamesPlayed += 1
        lastWinner = "Player One"
        let calculateScoreOnePercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage) = calculateScoreOnePercentage
        if scoreOne > scoreTwo {
            currentChampion = nickName
        } else if scoreOne == scoreTwo {
            currentChampion = "Draw"
        }
    }
    
    func playerTwoAddStats() {
        scoreTwo += 1
        lastWinner = "\(opponentsName!)"
        totalGamesPlayed += 1
        let calculateScoreTwoPercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreTwoWinPercentage, scoreOneWinPercentage) = calculateScoreTwoPercentage
        
        if scoreTwo > scoreOne {
            currentChampion = opponentsName!
        } else if scoreTwo ==  scoreOne {
            currentChampion = "Draw"
        }
    }
    
    func drawAddStats() {
        lastWinner = "Draw"
        totalGamesPlayed += 1
        draws += 1
        var drawPercentage = scoreOne + scoreTwo - 100
        drawPercentage = abs(drawPercentage)
    }
    
    
    //MARK:- IBActions/button pressed
    @IBAction func playerOneButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
        print("player One Button PressedÁ")
    }
    
    @IBAction func playerTwoButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        buttonPressedTag = sender.tag
    }
    
    
    
    
}
