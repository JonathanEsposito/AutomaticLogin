//
//  ProfileViewController.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ChangePasswordVCDelegate {
    //MARK: - Properties
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    
    let kuserDefaultsLoginKey = "userLogin"
    var login: Login?
    var profile: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        if login != nil {
            profile = Profiles.getProfile(withUserName: login!.userName)
            nameTextField.text = profile?.name
            userNameTextField.text = profile?.userName
            passwordTextField.text = profile?.password
            if let profile = profile {
                if let name = profile.name {
                    welcomeLabel.text = "Welcome \(name)!"
                }
                welcomeLabel.text = "Welcome \(profile.userName)!"
            }
            
            let test = UserDefaults.standard.object(forKey: kuserDefaultsLoginKey)
            if test != nil {
                autoLoginSwitch.isOn = true
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangePassword" {
            if let destinationVC = segue.destination as? ChangePasswordViewController {
                if let login = login {
                    destinationVC.oldPassword = login.password
                    destinationVC.changePasswordVCDelegate = self
                }
            }
        }
    }
    
    // MARK: - ChangePasswordVCDelegate
    func updateProfile(withNewPassword newPassword: String) {
        if profile != nil {
            profile!.password = newPassword
            passwordTextField.text = newPassword
            Profiles.update(profile: self.profile!)
            
            // Update user defaults
            if autoLoginSwitch.isOn {
                toggleAutoLogin(autoLoginSwitch)
            }
            
        }
    }
    
    // MARK: - Actions
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: kuserDefaultsLoginKey)
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func toggleAutoLogin(_ sender: UISwitch) {
        switch sender.isOn {
        case false: // it was on, now turn it off
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: kuserDefaultsLoginKey)
            print("truned off")
            userDefaults.synchronize()
        case true: // it was of, now turn it on
            let optionaLogin = getLoginFromInputFields()
            guard let login = optionaLogin else { print("cannot save login"); return }
            let userDefaults = UserDefaults.standard
            let encodedLogin: Data = NSKeyedArchiver.archivedData(withRootObject: login)
            userDefaults.set(encodedLogin, forKey: kuserDefaultsLoginKey)
            userDefaults.synchronize()
        }
    }
    
    @IBAction func updateProfileName(_ sender: UIBarButtonItem) {
        if profile != nil {
            self.profile!.name = nameTextField.text
            Profiles.update(profile: self.profile!)
        }
    }
    
    // MARK: - Private Methods
    private func getLoginFromInputFields() -> Login? {
        if userNameTextField.text != nil && userNameTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != "" {
            return Login(userName: userNameTextField.text!, password: passwordTextField.text!)
        }
            showAlert("Not all fields are filled out!", withTitle: "Warning!")
        return nil
    }
    
    private func showAlert(_ alert: String, withTitle title: String){
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

}
