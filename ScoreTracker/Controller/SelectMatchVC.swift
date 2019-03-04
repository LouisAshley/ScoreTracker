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
    
    // Variables
    var matchesArray = [Matches]()
    var selectedMatch: String? {
        didSet {
            
        }
    }
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath)
        cell.textLabel?.text = matchesArray[indexPath.row].opponents
        return cell
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesArray.count
    }
    
    
    //MARK:- Functions
    func updateNavBar() {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation bat does not exist")}
        navBar.prefersLargeTitles = true
        navBar.prefersLargeTitles = true
        title = selectedMatch
    }
    

}
