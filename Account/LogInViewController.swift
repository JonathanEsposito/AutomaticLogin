//
//  ViewController.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    let kuserDefaultsLoginKey = "userLogin"
    let userDefaults = UserDefaults.standard
    
    var login: Login?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // if a login object is being saved to UserDefaults, use this object to log in and do the segue
        if userDefaults.object(forKey: kuserDefaultsLoginKey) != nil {
            // set login property to object from UserDefaults
            login = loadSavedLogin()
            // perform segue and log in
            performSegue(withIdentifier: "LogInSegue", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // If we want to log in perform segue conditionaly
        if identifier == "LogInSegue" {
            checkUserInput()
            guard let login = login else {
                print("Something went wrong with the login...")
                return false
            }
            print(rememberMeSwitch.isOn)
            if rememberMeSwitch.isOn {
                saveLoginToUserDefaults()
            }
            if !Profiles.checkCredentials(forLogin: login) {
                showAlert("Username or password incorrect.", withTitle: "Login failed!")
            }
            return Profiles.checkCredentials(forLogin: login)
        }
        
        // If we want to do any other segue, do segue
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogInSegue", let destinationVC = segue.destination as? ProfileViewController {
            if let login = login {
                destinationVC.login = login
            }
        
        } else if segue.identifier == "SignUpSegue", let destinationVC = segue.destination as? SignUpViewController {
            destinationVC.login = Login(userName: userNameTextField.text ?? "", password: passwordTextField.text ?? "")
        }
    }
    
    
    
    // MARK: - Private Methods
    private func checkUserInput() {
        if userNameTextField.text != nil && userNameTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != "" {
            self.login = Login(userName: userNameTextField.text!, password: passwordTextField.text!)
        } else {
            self.showAlert("Not all fields are filled out!", withTitle: "Warning")
        }
    }
    
    private func saveLoginToUserDefaults() {
        let userDefaults = UserDefaults.standard
        let encodedLogin: Data = NSKeyedArchiver.archivedData(withRootObject: login!)
        userDefaults.set(encodedLogin, forKey: kuserDefaultsLoginKey)
        userDefaults.synchronize()
    }
    
    private func loadSavedLogin() -> Login {
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: kuserDefaultsLoginKey) as! Data
        let decodedLogin = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Login
        
        return decodedLogin
    }
    
    private func showAlert(_ alert: String, withTitle title: String){
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

