//
//  ChangePasswordViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 15.04.2023.
//

import UIKit

final class ChangePasswordViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet private var oldPasswordTextField: UITextField!
    @IBOutlet private var newPasswordTextField: UITextField!
    @IBOutlet private var newPasswordAgainTextField: UITextField!
    
    @IBOutlet var buttonOutlet: UIButton!
    
    
    
    //MARK: - Properties.
    private var changePasswordViewModel: ChangePasswordViewModel = ChangePasswordViewModel()

    //MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changePasswordViewModel.delegate = self
        
    }
    
    //MARK: - Functions.
    @IBAction func changePasswordButtonClicked(_ sender: UIButton) {
        guard let oldPassword = oldPasswordTextField.text else { return }
        guard let newPassword = newPasswordTextField.text else { return }
        guard let newPasswordAgain = newPasswordAgainTextField.text else { return }
        if newPassword == newPasswordAgain {
            changePasswordViewModel.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        } else {
            showAlert(titleText: "Password unmatched", messageText: "")
        }
    }
}

extension ChangePasswordViewController: ChangePasswordViewModelDelegate {
    func passwordChangingResult(_ result: Bool) {
        if result {
            showAlertWithHandler(titleText: "Password Changed successfully", messageText: "You have to sign in again", cancelButtonActive: false) { _ in
                self.dismiss(animated: true)
            }
        } else {
            showAlert(titleText: "Password could not changed.", messageText: "Check your informations.")
        }
    }
}
