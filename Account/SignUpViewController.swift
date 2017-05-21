//
//  SignUpViewController.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    
    let kuserDefaultsProfileKey = "userProfile"
    
    var login: Login?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // If we have a login
        if let login = self.login {
            userNameTextField.text = login.userName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    @IBAction func saveNewAccount(_ sender: UIButton) {
        if userNameTextField.text != nil && userNameTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != "" {
            saveProfile()
        }
    }
    
    // MARK: - Private Methods
    private func saveProfile() {
        guard passwordTextField.text == verifyPasswordTextField.text else {
            showAlert("Check if the verification password is the same as your password.", withTitle: "Passwordverification failed!")
            verifyPasswordTextField.text = nil
            return
        }
        
        captureLogin()
        if let login = self.login {
            if Profiles.isUnique(login: login) {
                Profiles.addAndSave(newProfile: Profile(name: nil, userName: login.userName, password: login.password))
                _ = self.navigationController?.popViewController(animated: true)
                
            } else {
                showAlert("The username you used already exists. Try using an other username.", withTitle: "Failed to create new profile!")
                userNameTextField.becomeFirstResponder()
            }
        }
    }
    
    private func captureLogin() {
        if let _ = self.login {
            self.login?.userName = userNameTextField.text!
            self.login?.password = passwordTextField.text!
        } else {
            self.login = Login(userName: userNameTextField.text!, password: passwordTextField.text!)
        }
    }
    
    private func showAlert(_ alert: String, withTitle title: String){
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
