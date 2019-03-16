//
//  SelectMatchVC.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SelectMatchVC: UITableViewController {
    
    // Constants
    let userID = Auth.auth().currentUser?.displayName
    
    // Variables
    var username: String?
    var usernameRef: DocumentReference!
    var selectedMatch: String?
    var opponents = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = selectedMatch
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        loadSavedOpponents()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = userID else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath) as? CustomCell {
            cell.configMatchesCell(username: user, opponentsName: opponents[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opponents.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadSavedScores(selectedMatch: selectedMatch!, index: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_SELECTED_GAME_VC {
            let destinationVC = segue.destination as! SelectedGameVC
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.opponentsName = opponents[indexPath.row]
                destinationVC.selectedMatch = selectedMatch!
                destinationVC.username = userID
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    //MARK:-  Load and save functions
    func loadSavedScores(selectedMatch: String, index: Int) {
        guard let user = userID else { return }
        let scoreReference = Firestore.firestore().collection(selectedMatch).document(user).collection(OPPONENTS).document("\(opponents[index])")
        SVProgressHUD.show()
        scoreReference.getDocument { (snapshot, error) in
            if let error = error {
                print("error retrieving score data \(error)")
            } else {
                guard let data = snapshot else {return}
                scoreOne = data["scoreOne"] as? Double ?? 0.0
                scoreTwo = data["scoreTwo"] as? Double ?? 0.0
                scoreOneWinPercentage = data["scoreOneWinPercentage"] as? Double ?? 0.0
                scoreTwoWinPercentage = data["scoreTwoWinPercentage"] as? Double ?? 0.0
                draws = data["draws"] as? Double ?? 0.0
                drawsPercentage = data["drawPercentage"] as? Double ?? 0.0
                totalGamesPlayed = data["totalGamesPlayed"] as? Double ?? 0.0
                lastWinner = data["lastWinner"] as? String ?? ""
                currentChampion = data["currentChampion"] as? String ?? ""
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: GO_TO_SELECTED_GAME_VC, sender: nil)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func loadSavedOpponents() {
        guard let user = userID,
            let match = selectedMatch else { return }
        SVProgressHUD.show()
        let opponentsRef = Firestore.firestore().collection(match).document(user).collection(OPPONENTS)
        opponentsRef.getDocuments() { (snapshot, error) in
            if let err = error {
                print("Error getting documents \(err)")
            } else {
                if let snap = snapshot?.documents {
                    for document in snap {
                        self.opponents.append(document.documentID)
                    }
                }
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK:- IBActions/Button Pressed
    @IBAction func addNewOpponent(_ sender: UIBarButtonItem) {
        guard let user = userID,
            let matchChosen = selectedMatch else { return }
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Opponent", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newOpponentsName = textField.text!
            self.opponents.append(newOpponentsName)
            let player = Firestore.firestore().collection(matchChosen).document(user).collection(OPPONENTS).document(newOpponentsName)
            player.setData([
                "user" : "exists"
                ])
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Opponent"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
        tableView.reloadData()
    }
    
}



