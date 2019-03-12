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
    
    // Constants
    let user = Auth.auth().currentUser?.email
    // Variables
    var nickNameRef: DocumentReference!
    var opponentsName: String?
    var selectedMatch: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        navigationItem.title = "Who Won?"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setBackground()
        setLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK:- Segueways functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let unwindDestination = segue.destination as! SelectedGameVC
        whatButtonWasPressed(sender: sender as! UIButton, vc: unwindDestination)
        saveScoreData(selectedGame: unwindDestination)
    }
    
    //MARK:- functions
    func setLabels() {
        playerOneWonLabel.setTitle(nickName, for: .normal)
        playerTwoWonLabel.setTitle("\(opponentsName!)", for: .normal)
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
    
    func whatButtonWasPressed(sender: UIButton, vc: SelectedGameVC) {
        switch sender.tag {
        case 2:
            playerOneAddStats(selectedGame: vc)
        case 3:
            playerTwoAddStats(selectedGame: vc)
        case 4:
            drawAddStats(selectedGame: vc)
        default:
            return
        }
    }
    
    func playerOneAddStats(selectedGame: SelectedGameVC) {
        totalGamesPlayed += 1
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
    
    func playerTwoAddStats(selectedGame: SelectedGameVC) {
        totalGamesPlayed += 1
        scoreTwo += 1
        lastWinner = "\(opponentsName!)"
        let calculateScoreTwoPercentage = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateScoreTwoPercentage
        if scoreTwo > scoreOne {
            currentChampion = opponentsName!
        } else if scoreTwo > scoreOne {
            currentChampion = "Draw"
        }
    }
    
    func drawAddStats(selectedGame: SelectedGameVC) {
        totalGamesPlayed += 1
        draws += 1
        lastWinner = "Draw"
        let calculateDraws = PertentageCalc(scoreOne: scoreOne, scoreTwo: scoreTwo, draws: draws, totalGames: totalGamesPlayed).calculatePercentage()
        (scoreOneWinPercentage, scoreTwoWinPercentage, drawsPercentage) = calculateDraws
    }
    
    //MARK:- Load and save functions
    func saveScoreData(selectedGame: SelectedGameVC) {
        Firestore.firestore().collection(selectedMatch!).document(user!).collection("opponents").document("\(self.opponentsName!)").setData([
            "scoreOne" : scoreOne,
            "scoreTwo" : scoreTwo,
            "scoreOneWinPercentage" : scoreOneWinPercentage,
            "scoreTwoWinPercentage" : scoreTwoWinPercentage,
            "draws" : draws,
            "drawPercentage" : drawsPercentage,
            "totalGamesPlayed" : totalGamesPlayed,
            "lastWinner" : lastWinner,
            "currentChampion" : currentChampion
            ], merge: true)
    }
    
    //MARK:- IBActions/button pressed
    @IBAction func playerOneButton(_ sender: UIButton) {
        
    }
    
    @IBAction func playerTwoButton(_ sender: UIButton) {
        
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        
    }
    
    
    
    
}
