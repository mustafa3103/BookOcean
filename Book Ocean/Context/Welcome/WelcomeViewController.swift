//
//  WelcomeViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import UIKit

final class WelcomeViewController: UIViewController, Transition {

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        navigatePageWithPush(nameText: "Login", identifier: "LoginScreen")
    }
    
    @IBAction func SignUpButtonClicked(_ sender: UIButton) {
        navigatePageWithPush(nameText: "Signup", identifier: "SignupScreen")
    }
}
