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
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                print("Error was occured. Error: \(error)")
            }
        }
    }
}
