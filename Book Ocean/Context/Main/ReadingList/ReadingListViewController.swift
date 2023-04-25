//
//  ReadingListViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 14.04.2023.
//

import UIKit

final class ReadingListViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet private var readingListTableView: UITableView!
    
    //MARK: - Properties.
    private var readingListVM: ReadingListViewModel = ReadingListViewModel()

    // MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readingListVM.delegate = self
        
        readingListTableView.register(UINib(nibName: "NewBookTableViewCell", bundle: nil), forCellReuseIdentifier: "addNewBookCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readingListVM.loadDataFromFirebase()
    }
}

extension ReadingListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        readingListVM.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addNewBookCell", for: indexPath) as? NewBookTableViewCell else { return UITableViewCell() }
        let book = readingListVM.books[indexPath.row]
        cell.bookName.text = book.title
        cell.authorName.text = book.author
        let imageUrl = book.imageLink
        cell.bookImage.sd_setImage(with: URL(string: imageUrl))
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = readingListVM.books[indexPath.row]
        let storyboard = UIStoryboard(name: "SelectedBook", bundle: nil)
        guard let selectedBookVC = storyboard.instantiateViewController(withIdentifier: "selectedBook") as? SelectedBookViewController else { return }
        selectedBookVC.selectedBookVM.selectedBookFromFB = selectedBook
        selectedBookVC.buttonState = false
        navigationController?.pushViewController(selectedBookVC, animated: true)
    }
}

extension ReadingListViewController: ReadingListViewModelDelegate {
    func loadedData() {
        readingListTableView.reloadData()
    }
}
