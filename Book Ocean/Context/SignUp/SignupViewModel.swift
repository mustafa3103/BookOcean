//
//  SignupViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 21.03.2023.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    
}

protocol SignUpViewModelProtocol: AnyObject {
    func signUpNewUser(email: String, password: String, rePassword: String, name: String, surname: String)
}

final class SignUpViewModel: SignUpViewModelProtocol {
    
    weak var delegate: SignUpViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()
    
    func signUpNewUser(email: String, password: String, rePassword: String, name: String, surname: String) {
        if password == rePassword {
            let newUser = UserModel(email: email, name: name, surname: surname, password: password)
            let signUpResult = firebaseManager.signUpUser(user: newUser)
            
            if signUpResult {
                // User created succesfully.
            } else {
                // Error was occured.
            }
        } else {
            // Password unmatched.
        }
        
    }
}
