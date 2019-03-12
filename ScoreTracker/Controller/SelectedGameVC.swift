//
//  ViewController.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 02/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

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
    let user = Auth.auth().currentUser?.email
    //Variables
    var nickNameRef: DocumentReference!
    var selectedMatch: String?
    var opponentsName: String?
    
    //MARK:- Views loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        navigationItem.title = selectedMatch
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setLabels()
        setBackground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK:- Set up game labels and buttons functions
    func setLabels() {
        scoreLabelOne.text = "\(nickName): \n\(scoreOne)"
        scoreLabelTwo.text = "\(opponentsName!): \n\(scoreTwo)"
        drawLabel.text = "Draws: \(Int(draws))"
        winnngPercentageLabelOne.text = "Winning Percentage: \n\(Int(scoreOneWinPercentage))%"
        winningPercentageLabelTwo.text = "Winning percentage: \n\(Int(scoreTwoWinPercentage))%"
        drawPercentageLabel.text = "Draw Percentage: \(Int(drawsPercentage))%"
        currentChampionLabel.text = "Current Champion: \(currentChampion)"
        totalGamesPlayedLabel.text = "Games Played: \(Int(totalGamesPlayed))"
        lastWinnerLabel.text = "Last Winner: \(lastWinner)"
        gameNameLabel.text = "\(selectedMatch!)"
    }
    
    func setBackground() {
        switch selectedMatch {
        case "Chess":
            backgroundOutlet.image = UIImage(named: CHESS)
        case "Pool":
            backgroundOutlet.image = UIImage(named: POOL)
        case "Tennis":
            backgroundOutlet.image = UIImage(named: TENNIS)
        default:
            return
        }
    }
    
    
    
    //MARK:- Load scores
    func saveScoreData() {
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
            destinationVC.selectedMatch = selectedMatch
        }
    }
    
    @IBAction func addNewVictoryButton(_ sender: UIButton) {
        
    }
    
    @IBAction func unwindToSelectedGameVC(_ sender: UIStoryboardSegue) {}
    
}


