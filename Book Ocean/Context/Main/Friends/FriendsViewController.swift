//
//  FriendsViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit

final class FriendsViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet var friendsTableView: UITableView!
    
    //MARK: - Properties.
    private var viewModel: FriendsViewModel = FriendsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        friendsTableView.register(UINib(nibName: "FriendCustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchFriend")
        viewModel.delegate = self
        viewModel.loadFriends()
    }

    @IBAction private func searchButtonClicked(_ sender: UIButton) {
        navigatePageWithPush(nameText: "SearchFriend", identifier: "searchFriend")
    }
}

extension FriendsViewController: FriendsViewModelDelegate {
    func loadedFriends() {
        friendsTableView.reloadData()
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.userFriends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchFriend", for: indexPath) as? FriendCustomCellTableViewCell else { return UITableViewCell() }
        
        
        cell.userName.text = viewModel.userFriends[indexPath.row].name
        cell.userSurname.text = viewModel.userFriends[indexPath.row].surname
        cell.userEmail.text = viewModel.userFriends[indexPath.row].email
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Seçilen indexteki arkadaşı firebase üzerinden sil.
            let selectedFriend = viewModel.userFriends[indexPath.row]
            viewModel.deleteSelectedFriend(at: indexPath.row)
            viewModel.userFriends.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
