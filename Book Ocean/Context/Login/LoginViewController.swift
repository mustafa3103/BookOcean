//
//  LoginViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import UIKit

final class LoginViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    //MARK: - Properties
    private var viewModel: LoginViewModel = LoginViewModel()

    // MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    //MARK: - Functions
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if email.count > 3 && password.count > 3 {
            viewModel.loginToApplication(email: email, password: password)
        } else {
            // Show error due to user did not enter enough characters.
        }
    }
    
    @IBAction private func forgetButtonClicked(_ sender: UIButton) {
        navigatePageWithPresent(nameText: "Forget", identifier: "forgetScreen")
    }
}
//MARK: - LoginViewController's delegate.
extension LoginViewController: LoginViewModelDelegate {
    func loginStateControl(result: Bool) {
        if result {
            navigatePageWithPresent(nameText: "Main", identifier: "toMainTabBar")
        } else {
            // Show error
        }
    }
}
