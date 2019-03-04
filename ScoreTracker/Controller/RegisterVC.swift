//
//  registerVC.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterVC: UIViewController {
    //MARK:- Outlets, Constants & Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    // Constants
    
    //Variables
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK:- IBActions/Button Pressed
    
    
    //Adds user details to Firebase and sets up a nick name in the playerDetails.swift
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        var textFieldString = UITextField()
        let alert = UIAlertController(title: "Add Nickname", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            SVProgressHUD.show()
            let playerDetails = PlayerDetails()
            playerDetails.nickName = textFieldString.text!
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                if error != nil {
                    print(error!)
                    SVProgressHUD.dismiss()
                } else {
                    print("Registration Successful")
                    self.performSegue(withIdentifier: GO_TO_CHOOSE_GAME_VC, sender: self)
                    SVProgressHUD.dismiss()
                }
            }
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Your Nickname"
            textFieldString = alertTextField
        }
        present(alert, animated: true)
    }
    
    
    
    
    
}



