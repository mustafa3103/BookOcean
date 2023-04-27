//
//  ChangePasswordViewModel.swift
//  Book Ocean
//
//  Created by Mustafa on 15.04.2023.
//

import Foundation

protocol ChangePasswordViewModelDelegate: AnyObject {
    func passwordChangingResult(_ result: Bool)
}

protocol ChangePasswordViewModelProtocol: AnyObject {
    func changePassword(oldPassword: String, newPassword: String)
}

final class ChangePasswordViewModel: ChangePasswordViewModelProtocol {

    weak var delegate: ChangePasswordViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()

    func changePassword(oldPassword: String, newPassword: String) {
        let currentUserEmail = firebaseManager.getCurrentUserEmail()
        var currentUserModel: UserModel?
        firebaseManager.getAllUsers { users, documentIDs in
            for user in users {
                if user.email == currentUserEmail {
                    currentUserModel = user
                    
                    guard let currentUser = currentUserModel else { return }
                    if currentUser.password == oldPassword {
                        self.firebaseManager.changePassword(newPassword: newPassword) { result in
                            if result {
                                self.delegate?.passwordChangingResult(result)
                            } else {
                                self.delegate?.passwordChangingResult(result)
                            }
                        }
                    }
                }
            }
        }
    }
}
