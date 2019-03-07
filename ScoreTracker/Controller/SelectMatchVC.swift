//
//  SelectMatchVC.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase

class SelectMatchVC: UITableViewController {
    
    //MARK:- Outlets, Constants & Variables
    
    // Constants
    let user = Auth.auth().currentUser
    // Variables
    var selectedMatch: String? {
        didSet {
            //saveItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = selectedMatch
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_SELECTED_GAME_VC {
            let destinationVC = segue.destination as! SelectedGameVC
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.opponentsName = opponents[indexPath.row]
                destinationVC.chosenGameName = selectedMatch
            }
        }
    }
    
    
    //MARK:- Functions

    //MARK:- IBActions/Button Pressed
    @IBAction func addNewOpponent(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Opponent", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newOpponentsName = textField.text!
                opponents.append(newOpponentsName)
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
