//
//  LoginViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func loginStateControl(result: Bool)
}

protocol LoginViewModelProtocol: AnyObject {
    func loginToApplication(email: String, password: String)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    //MARK: - Properties.
    weak var delegate: LoginViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()

    //MARK: - Functions
    func loginToApplication(email: String, password: String) {
        firebaseManager.loginWithFirebase(email: email, password: password) { result in
            if result {
                // Segue
                self.delegate?.loginStateControl(result: true)
            } else {
                // Couldnt log in app
                self.delegate?.loginStateControl(result: false)
            }
        }
    }
}
