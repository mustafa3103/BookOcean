//
//  FriendsViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import Foundation

protocol FriendsViewModelDelegate: AnyObject {
    func loadedFriends()
}

protocol FriendsViewModelProtocol: AnyObject {
    func loadFriends()
}

final class FriendsViewModel: FriendsViewModelProtocol {
    
    weak var delegate: FriendsViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()
    var userFriends: [UserModel] = [UserModel]()
    
    func loadFriends() {
        firebaseManager.getCurrentUserFriends { friends in
            self.userFriends = friends
            self.delegate?.loadedFriends()
        }
    }
}
