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
    @IBOutlet weak var loginDetailsIncorrectLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginDetailsIncorrectLabel.isHidden = true
        emailTextField.placeholder = "Enter Email"
        emailTextField.textAlignment = .center
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.textAlignment = .center
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.userTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func userTapped() {
        self.view.endEditing(true)
    }

    //MARK:- IBActions/Button Pressed
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (userDetail, error) in
            if let error = error {
                debugPrint("Error signing in \(error)")
                SVProgressHUD.dismiss()
                self.loginDetailsIncorrectLabel.isHidden = false
            } else {
                self.dismiss(animated: true, completion: nil)
                SVProgressHUD.dismiss()
                
            }
        }
    }
}







