//
//  SettingsViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit

final class SettingsViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet var aboutButtonOutlet: UIButton!
    @IBOutlet var changePasswordButtonOutlet: UIButton!
    @IBOutlet var exitButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func aboutButtonClicked(_ sender: UIButton) {
        navigatePageWithPush(nameText: "About", identifier: "aboutVC")
    }
    
    @IBAction func changePasswordButtonClicked(_ sender: UIButton) {
        // Şifreyi değiştirme yerine segue yap.
        navigatePageWithPush(nameText: "ChangePassword", identifier: "changePassword")
    }
    
    
    @IBAction func exitButtonClicked(_ sender: UIButton) {
        showAlertWithHandler(titleText: "Are you sure want to exit from application?", messageText: "", cancelButtonActive: true) { _ in
            let firebaseManager: FirebaseManager = FirebaseManager()
            firebaseManager.logOut()
            self.dismiss(animated: true)
        }
    }
}
