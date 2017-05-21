//
//  ChangePasswordViewController.swift
//  Account
//
//  Created by .jsber on 06/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

protocol ChangePasswordVCDelegate {
    func updateProfile(withNewPassword: String)
}

class ChangePasswordViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordVerificationTextField: UITextField!
    
    var oldPassword: String?
    var changePasswordVCDelegate: ChangePasswordVCDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - IBAction
    @IBAction func saveChangedPassword(_ sender: UIButton) {
        if oldPasswordIsCorrect() && newPasswordComplies() {
            let newPassword = newPasswordTextField.text!
            changePasswordVCDelegate?.updateProfile(withNewPassword: newPassword)
            
            _ = self.navigationController?.popViewController(animated: true)
        }
        if !oldPasswordIsCorrect() {
        showAlert("Old passwords is not correct!", withTitle: "Warning!")
        } else if !newPasswordComplies() {
            showAlert("Verification password is not the same!", withTitle: "Warning!")
        }
    }
    
    // MARK: - Private Methods
    private func oldPasswordIsCorrect() -> Bool {
        return oldPassword == oldPasswordTextField.text
    }
    
    private func newPasswordComplies() -> Bool {
        return newPasswordTextField.text != nil && newPasswordTextField.text != "" && (newPasswordTextField.text == newPasswordVerificationTextField.text)
    }
    
    private func showAlert(_ alert: String, withTitle title: String){
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
