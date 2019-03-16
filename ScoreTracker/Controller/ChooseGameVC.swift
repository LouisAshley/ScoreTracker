//
//  ChooseGameVC.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase
private var handle: AuthStateDidChangeListenerHandle?

class ChooseGameVC: UITableViewController {
    //MARK:- Outlets, Constants & Variables
    @IBOutlet weak var cellBackgroundImage: UIView!
    @IBOutlet weak var userDetailsButton: UIBarButtonItem!
    
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC")
                self.present(loginVC, animated: true, completion: nil)
            }
        })
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableView.rowHeight = 80
    }

    //MARK: - TableView & SwipeTableView delegate methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gameTypeCell", for: indexPath) as? CustomCell {
        cell.configGamesCell(gameType: gameTypeArray[indexPath.row])
        cell.gameNameText.text = gameTypeArray[indexPath.row]
        return cell
        } else {
            return UITableViewCell()
        }
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
        } catch let signoutError as NSError {
            debugPrint("Error signing out \(signoutError)")
        }
    }
    
    @IBAction func userDetailsButtonTapped(_ sender: Any) {
        
    }
}
