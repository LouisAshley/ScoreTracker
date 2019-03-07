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
    @IBOutlet weak var invalidEmailAlertLabel: UILabel!
    
    // Constants
    
    //Variables
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmailAlertLabel.isHidden = true
    }
    
    
    //MARK:- IBActions/Button Pressed
    
    
    //Adds user details to Firebase and sets up a nick name in the playerDetails.swift
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        var textFieldString = UITextField()
        let alert = UIAlertController(title: "Add Your Name", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                if error != nil {
                    print(error!)
                    self.view.endEditing(true)
                    SVProgressHUD.dismiss()
                    self.invalidEmailAlertLabel.isHidden = false
                } else {
                    guard let inputtedName = textFieldString.text else { return }
                    Firestore.firestore().collection(USER_DETAILS_REF).document(self.emailTextField.text!).setData([
                        USER_EMAIL : self.emailTextField.text!,
                        USER_NAME : inputtedName
                    ]) { (error) in
                        if let error = error {
                            print("error adding username document \(error)")
                        } else {
                            print("successfully added username document")
                        }
                    }
                    nickName = textFieldString.text!
                    self.performSegue(withIdentifier: GO_TO_CHOOSE_GAME_VC, sender: self)
                    SVProgressHUD.dismiss()
                }
            }
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Your Name"
            textFieldString = alertTextField
        }
        present(alert, animated: true)
    }
    
    
    
    
}



