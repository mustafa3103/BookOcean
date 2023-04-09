//
//  ForgetViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 21.03.2023.
//

import UIKit

final class ForgetViewController: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var emailTextField: UITextField!

    //MARK: - Properties
    private var forgetViewModel: ForgetViewModel = ForgetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPasswordButtonClicked(_ sender: UIButton) {
        // Firebase kullanılarak şifre sıfırlaması yapılacak.
        guard let email = emailTextField.text else { return }
        forgetViewModel.resetPassword(email: email)
    }
}
