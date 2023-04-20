//
//  SelectedBookCategoryViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import UIKit

final class SelectedBookCategoryViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet private var selectedBookCategoryTableView: UITableView!

    //MARK: - Properties.
    var selectedBookCategoryVM: SelectedBookCategoryViewModel = SelectedBookCategoryViewModel()
    
    //MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedBookCategoryTableView.register(UINib(nibName: "NewBookTableViewCell", bundle: nil), forCellReuseIdentifier: "addNewBookCell")
        selectedBookCategoryVM.delegate = self
        selectedBookCategoryVM.loadData()
    }
}

//MARK: - Tableview delegate and datasource methods.
extension SelectedBookCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedBookCategoryVM.bookDataModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addNewBookCell", for: indexPath) as? NewBookTableViewCell else { return UITableViewCell() }
        cell.bookName.text = selectedBookCategoryVM.bookDataModel[indexPath.row].volumeInfo.title
        cell.authorName.text = selectedBookCategoryVM.bookDataModel[indexPath.row].volumeInfo.authors?.first
        if let imageUrl = selectedBookCategoryVM.bookDataModel[indexPath.row].volumeInfo.imageLinks?.first?.value {
            cell.bookImage.sd_setImage(with: URL(string: imageUrl))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = selectedBookCategoryVM.bookDataModel[indexPath.row]
        let storyboard = UIStoryboard(name: "SelectedBook", bundle: nil)
        guard let selectedBookVC = storyboard.instantiateViewController(withIdentifier: "selectedBook") as? SelectedBookViewController else { return }
        selectedBookVC.selectedBookVM.selectedBook = selectedBook
        selectedBookVC.buttonState = true
        navigationController?.pushViewController(selectedBookVC, animated: true)
    }
}
extension SelectedBookCategoryViewController: SelectedBookCategoryDelegate {
    func dataIsLoaded() {
        selectedBookCategoryTableView.reloadData()
    }
}
