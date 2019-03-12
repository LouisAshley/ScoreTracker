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
    
    //MARK:- Outlets, Constants & Variables
    
    // Constants
    let user = Auth.auth().currentUser?.email
    
    // Variables
    var nickNameRef: DocumentReference!
    var selectedMatch: String?
    var opponents = [String]()
//    var player: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = selectedMatch
        loadSavedOpponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveNickName()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath)
        cell.textLabel?.text = "\(nickName) vs \(opponents[indexPath.row])"
        return cell
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
                
            }
        }
    }
    
    //MARK:-  Load and save functions
    func loadSavedScores(selectedMatch: String, index: Int) {
        let scoreReference = Firestore.firestore().collection(selectedMatch).document(user!).collection("opponents").document("\(opponents[index])")
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
        SVProgressHUD.show()
        let opponentsRef = Firestore.firestore().collection(selectedMatch!).document(user!).collection(OPPONENTS)
        opponentsRef.getDocuments() { (snapshot, error) in
            if let err = error {
                print("Error getting documents \(err)")
            } else {
                for document in (snapshot?.documents)! {
                    print("\(document.documentID)")
                    self.opponents.append(document.documentID)
                }
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    func retrieveNickName() {
        nickNameRef = Firestore.firestore().collection(USER_DETAILS_REF).document(user!)
        nickNameRef.getDocument { (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching docs: \(error)")
            } else {
                if let data = snapshot?.data() {
                    nickName = data[USER_NAME] as? String ?? "Anonymous"
                    self.tableView.reloadData()
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    //MARK:- IBActions/Button Pressed
    @IBAction func addNewOpponent(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Opponent", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newOpponentsName = textField.text!
            self.opponents.append(newOpponentsName)
            let player = Firestore.firestore().collection(self.selectedMatch!).document(self.user!).collection(OPPONENTS).document(newOpponentsName)
            player.setData(["Exists" : true])
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



