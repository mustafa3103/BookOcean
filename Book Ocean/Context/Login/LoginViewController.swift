//
//  LoginViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import UIKit

final class LoginViewController: UIViewController, Transition {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem?.tintColor = .white
    }

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        // toMainTabBar
        navigatePageWithPresent(nameText: "Main", identifier: "toMainTabBar")
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if email.count > 3 && password.count > 3 {
            
        } else {
            // Kullanıcıya yeterli sayıda karakter girmediği için hata göster.
        }
    }
    
    @IBAction func forgetButtonClicked(_ sender: UIButton) {
        navigatePageWithPresent(nameText: "Forget", identifier: "forgetScreen")
    }
    
}
