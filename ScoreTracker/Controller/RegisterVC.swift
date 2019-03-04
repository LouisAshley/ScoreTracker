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
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                print("Registration Successful")
                self.performSegue(withIdentifier: GO_TO_CHOOSE_GAME_VC, sender: self)
            }
        }
        
        
    }
    
    
    
    
    
}
