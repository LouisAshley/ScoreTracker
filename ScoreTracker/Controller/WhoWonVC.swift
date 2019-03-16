//
//  WhoWonVC.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 02/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase

class WhoWonVC: UIViewController {
    //MARK:- Variables, Constants & Outlets
    //Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var whoWonLabel: UILabel!
    @IBOutlet weak var playerOneWonLabel: UIButton!
    @IBOutlet weak var playerTwoWonLabel: UIButton!
    @IBOutlet weak var drawButtonLabel: UIButton!

    // Variables
    var username: String?
    var opponentsName: String?
    var selectedMatch: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setBackground()
        setLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        navigationItem.title = "Who Won?"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        saveScoreData()
    }
    func setLabels() {
        guard let user = username,
        let opponent = opponentsName else { return }
        playerOneWonLabel.setTitle(user, for: .normal)
        playerTwoWonLabel.setTitle("\(opponent)", for: .normal)
        drawButtonLabel.setTitle("Draw", for: .normal)
    }
    
    func setBackground() {
        switch selectedMatch {
        case "Chess":
            backgroundImage.image = UIImage(named: CHESSTWO)
        case "Pool":
            backgroundImage.image = UIImage(named: POOLTWO)
        case "Tennis":
            backgroundImage.image = UIImage(named: TENNISTWO)
        default:
            return
        }
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
    
    //MARK:- Segueways functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        whatButtonWasPressed(sender: sender as! UIButton)
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
        guard let user = username else { return }
        totalGamesPlayed += 1
        scoreOne += 1
        lastWinner = user
        let calculateScoreOnePercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateScoreOnePercentage
        if scoreOne > scoreTwo {
            currentChampion = username!
        } else if scoreOne == scoreTwo {
            currentChampion = "Draw"
        }
    }
    
    func playerTwoAddStats() {
        guard let opponent = opponentsName else { return }
        totalGamesPlayed += 1
        scoreTwo += 1
        lastWinner = "\(opponent)"
        let calculateScoreTwoPercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateScoreTwoPercentage
        if scoreTwo > scoreOne {
            currentChampion = opponentsName!
        } else if scoreTwo == scoreOne {
            currentChampion = "Draw"
        }
    }
    
    func drawAddStats() {
        totalGamesPlayed += 1
        draws += 1
        lastWinner = "Draw"
        let calculateDraws = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateDraws
    }
    
    //MARK:- Load and save functions
    func saveScoreData() {
        guard let user = username,
        let opponent = opponentsName else { return }
        Firestore.firestore().collection(selectedMatch!).document(user).collection("opponents").document("\(opponent)").setData([
            "scoreOne" : scoreOne,
            "scoreTwo" : scoreTwo,
            "scoreOneWinPercentage" : scoreOneWinPercentage,
            "scoreTwoWinPercentage" : scoreTwoWinPercentage,
            "draws" : draws,
            "drawPercentage" : drawsPercentage,
            "totalGamesPlayed" : totalGamesPlayed,
            "lastWinner" : lastWinner,
            "currentChampion" : currentChampion
            ])
        
    }
    
    
    
    
}
