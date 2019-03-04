//
//  logInVc.swift
//  ScoreTracker
//
//  Created by Lewis on 04/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInVC: UIViewController {
    //MARK:- Outlets, Constants & Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    
    // Constants
    
    // Variables
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    //MARK:- IBActions/Button Pressed
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (userDetail, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                print("Logged In Successfully")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: GO_TO_CHOOSE_GAME_VC, sender: self)
            }
        }
    }
}
