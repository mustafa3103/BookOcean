//
//  FriendsViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import Foundation

protocol FriendsViewModelDelegate: AnyObject {
    func loadedFriends(takenFriends: UserModel)
}

protocol FriendsViewModelProtocol: AnyObject {
    func loadFriends()
}

final class FriendsViewModel: FriendsViewModelProtocol {
    
    weak var delegate: FriendsViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()
    
    func loadFriends() {
        firebaseManager.getCurrentUserViaUserModel { user in
            self.delegate?.loadedFriends(takenFriends: user)
        }
    }
}
