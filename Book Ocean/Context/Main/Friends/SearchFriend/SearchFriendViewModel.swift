//
//  SearchFriendViewModel.swift
//  Book Ocean
//
//  Created by Mustafa on 20.04.2023.
//

import Foundation

protocol SearchFriendViewModelDelegate: AnyObject {
    func loadUsersFromFirebase(users: [UserModel])
}

protocol SearchFriendViewModelProtocol: AnyObject {
    var delegate: SearchFriendViewModelDelegate? { get set }
    func loadUser()
}

final class SearchFriendViewModel: SearchFriendViewModelProtocol {
    
    weak var delegate: SearchFriendViewModelDelegate?
    var userDataModel: [UserModel] = [UserModel]()
    var filteredUserDataModel: [UserModel] = [UserModel]()
    
    private var firebaseManager: FirebaseManager = FirebaseManager()
    // [UserModel]
    
    func loadUser() {
        firebaseManager.getAllUsers { users in
            self.userDataModel = users
            self.filteredUserDataModel = users
            self.delegate?.loadUsersFromFirebase(users: self.userDataModel)
        }
    }

    func sendFriendRequest(selectedUser: UserModel) {
        self.firebaseManager.addFriend(friendUserModel: selectedUser)
    }
}
