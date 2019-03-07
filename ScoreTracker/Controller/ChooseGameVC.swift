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
    var gameTypeArray = [String]()
    let user = Auth.auth().currentUser
    
    //Variables
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let games = ChosenGame()
        gameTypeArray = [games.chess, games.pool, games.tennis]
        Firestore.firestore().collection(USER_DETAILS_REF).document((user?.email)!).collection(USER_GAMES).addDocument(data: [
            "gameOne" : games.chess,
            "gameTwo" : games.pool,
            "gameThree" : games.tennis
            ])
    }
    

    //MARK: - TableView & SwipeTableView delegate methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameTypeCell", for: indexPath)
        cell.textLabel?.text = gameTypeArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTypeArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: GO_TO_CHOOSE_GAME_VC, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_CHOOSE_GAME_VC {
        let destinationVC = segue.destination as! SelectMatchVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedMatch = gameTypeArray[indexPath.row]
          }
        }
    }
    


    
    //MARK:- IBActions/Button Pressed
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("Logged Out Successfully")
            performSegue(withIdentifier: UNWIND_TO_WELCOMESCREEN_VC, sender: nil)
        } catch {
            print("Error Logging Out")
        }
    }
    
    
    
    
    
    
    
    
    
    
}
