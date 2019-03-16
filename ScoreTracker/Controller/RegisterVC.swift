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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var invalidEmailAlertLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    // Constants
    
    //Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmailAlertLabel.isHidden = true
        emailTextField.placeholder = "Enter Email"
        emailTextField.textAlignment = .center
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.textAlignment = .center
        usernameTextField.placeholder = "Enter Public Username"
        usernameTextField.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(userTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func userTapped() {
        view.endEditing(true)
    }
    
    //Adds user details to Firebase and sets up a nick name in the playerDetails.swift
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let username = usernameTextField.text else { return }
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user \(error.localizedDescription)")
                SVProgressHUD.dismiss()
                self.invalidEmailAlertLabel.isHidden = false
            }
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint("Error \(error.localizedDescription)")
                }
            })
            guard let userID = user?.user.uid else { return }
            Firestore.firestore().collection(USER_DETAILS_REF).document(userID).setData([
                USER_EMAIL : email,
                USER_NAME : username
                ])
            { (error) in
                if let error = error {
                    print("error adding username document \(error)")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}



