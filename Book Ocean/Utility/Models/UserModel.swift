//
//  userModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 6.04.2023.
//

import Foundation

struct UserModel {
    let email: String
    let name: String
    let surname: String?
    let password: String?
    var friends: [String]?
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "email": email,
            "name": name
        ]
        if let surname = surname {
            dict["surname"] = surname
        }
        if let password = password {
            dict["password"] = password
        }
        if let friends = friends {
            dict["friends"] = friends
        }
        return dict
    }
}
