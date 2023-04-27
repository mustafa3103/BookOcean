//
//  MainViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit
import SDWebImage

final class MainViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mainTableView: UITableView!

    // MARK: - Properties
    private var mainViewModel: MainViewModel = MainViewModel()
    private var books = [FirebaseBookModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        mainViewModel.loadData()
        mainViewModel.delegate = self
    }
    
    @IBAction private func addNewBook(_ sender: UIButton) {
        // Segue to New Items toAddNewBook
        navigatePageWithPresent(nameText: "AddNewBook", identifier: "toAddNewBook")
    }
}

// MARK: - TableView delegate and datasource methods.
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let book = books[indexPath.row]
        cell.userName.text = book.userEmail
        cell.authorName.text = book.author
        cell.userComment.text = book.userComment
        cell.bookName.text = book.title
        cell.authorImageView.sd_setImage(with: URL(string: book.imageLink))
        return cell
    }
}
// MARK: - MainViewModelDelegate methods.
extension MainViewController: MainViewModelDelegate {
    func loadedData(takenBooks: [FirebaseBookModel]) {
        books = takenBooks
        mainTableView.reloadData()
    }
}
