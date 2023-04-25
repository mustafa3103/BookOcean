//
//  SearchFriendViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 20.04.2023.
//

import UIKit
// Bütün kullanıcıları göster burada.
final class SearchFriendViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet var searchFriendTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: - Properties.
    private var viewModel: SearchFriendViewModel = SearchFriendViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchFriendTableView.register(UINib(nibName: "FriendCustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "searchFriend")
        viewModel.loadUser()
        viewModel.delegate = self
    }
}
// MARK: - TableView delegate and datasource methods.
extension SearchFriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tıklanınca alert göster ve duruma göre o kişiye arkadaşlık isteği gönder.
        let selectedUser = viewModel.filteredUserDataModel[indexPath.row]
        viewModel.sendFriendRequest(selectedUser: selectedUser)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchFriend", for: indexPath) as? FriendCustomCellTableViewCell else { return UITableViewCell() }
        
        cell.userName.text = viewModel.filteredUserDataModel[indexPath.row].name
        cell.userSurname.text = viewModel.filteredUserDataModel[indexPath.row].surname
        cell.userEmail.text = viewModel.filteredUserDataModel[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredUserDataModel.count
    }
}

extension SearchFriendViewController: SearchFriendViewModelDelegate {
    func loadUsersFromFirebase(users: [UserModel]) {
        searchFriendTableView.reloadData()
    }
}

extension SearchFriendViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchedFriend = searchText.lowercased()
        viewModel.filteredUserDataModel = viewModel.userDataModel.filter { user in
            return user.name.lowercased().contains(searchedFriend)
        }
        if searchText.isEmpty {
            viewModel.filteredUserDataModel = viewModel.userDataModel
        }
        searchFriendTableView.reloadData()
    }
}
