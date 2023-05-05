//
//  ForgetViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 21.03.2023.
//

import Foundation
import FirebaseAuth

protocol ForgetViewModelProtocol: AnyObject {
    func resetPassword(email: String)
}

final class ForgetViewModel: ForgetViewModelProtocol {

    private var firebaseManager: FirebaseManager = FirebaseManager()

    func resetPassword(email: String) {
        firebaseManager.resetPassword(email: email)
    }
}
