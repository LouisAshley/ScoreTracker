//
//  ChooseGameVC.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase

class ChooseGameVC: UITableViewController {
    //MARK:- Outlets, Constants & Variables
    
    //Constants
    let gameTypeArray = ["Chess", "Pool"]
    
    //Variables

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameTypeCell", for: indexPath)
        cell.textLabel?.text = gameTypeArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTypeArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK:- IBActions/Button Pressed

    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("Logged Out Successfully")
            performSegue(withIdentifier: UNWIND_TO_WELCOMESCREENVC, sender: nil)
        } catch {
            print("Error Logging Out")
        }
    }
    
    
    
    
    
    
    
    
}
