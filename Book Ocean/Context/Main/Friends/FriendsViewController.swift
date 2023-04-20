//
//  FriendsViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit

final class FriendsViewController: BaseViewController {

    private var viewModel: FriendsViewModel = FriendsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.loadFriends()
    }
}

extension FriendsViewController: FriendsViewModelDelegate {
    func loadedFriends(takenFriends: UserModel) {
        let friend = takenFriends
    }
}
