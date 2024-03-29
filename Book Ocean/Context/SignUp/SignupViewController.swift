//
//  SignupViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 21.03.2023.
//

import UIKit


final class SignupViewController: BaseViewController {

    // MARK: - Outlets.
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    // MARK: - Proporties.
    private var signUpViewModel: SignUpViewModel = SignUpViewModel()

    // MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpViewModel.delegate = self
    }

    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let rePassword = rePasswordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        guard let surname = surnameTextField.text else { return }
        
        signUpViewModel.signUpNewUser(email: email, password: password, rePassword: rePassword, name: name, surname: surname)
    }
}

extension SignupViewController: SignUpViewModelDelegate {
    func signUpStateControl(result: Bool) {
        if result {
            navigatePageWithPresent(nameText: "Main", identifier: "toMainTabBar")
        }
    }
}
