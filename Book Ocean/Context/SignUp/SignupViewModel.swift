//
//  SignupViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 21.03.2023.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    func signUpStateControl(result: Bool)
}

protocol SignUpViewModelProtocol: AnyObject {
    func signUpNewUser(email: String, password: String, rePassword: String, name: String, surname: String)
}

final class SignUpViewModel: SignUpViewModelProtocol {
    
    //MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()
    
    //MARK: - Functions
    func signUpNewUser(email: String, password: String, rePassword: String, name: String, surname: String) {
        if password == rePassword && password.count >= 6 {
            let newUser = UserModel(email: email, name: name, surname: surname, password: password)
                self.firebaseManager.signUpUser(user: newUser) { result in
                    if result {
                        // User created succesfully.
                        self.delegate?.signUpStateControl(result: result)
                        
                    } else {
                        // Error was occured.
                    }
                }
        } else {
            // Password unmatched.
            print("Password unmatched.")
        }
    }
}
