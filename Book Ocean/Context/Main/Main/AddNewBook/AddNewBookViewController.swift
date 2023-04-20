//
//  AddNewBookViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 26.03.2023.
//

import UIKit
import FirebaseFirestore
import SDWebImage

final class AddNewBookViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var addNewBookTableView: UITableView!
    @IBOutlet private weak var addNewBookSearchBar: UISearchBar!
    
    // MARK: - Properties
    private var viewModel: AddNewBookViewModel = AddNewBookViewModel()
    let db = Firestore.firestore()
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNewBookTableView.register(UINib(nibName: "NewBookTableViewCell", bundle: nil), forCellReuseIdentifier: "addNewBookCell")
        viewModel.delegate = self
        viewModel.loadData(nil)
    }
}
// MARK: - Methods.
extension AddNewBookViewController {
    private func addNewBookToFirebase(selectedBook: Int) {
        let alertController = UIAlertController(title: "What is your comment about book?", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Enter comment here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let okAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let userComment = alertController.textFields?.first {
                // Güncel kullanıcının mail adresini al
                // Güncel kullanıcının ismini Users collection'nı çağırarak mail adresi ile eşleştirip ondaki ismi ata.
                self.viewModel.addNewBookToFirebase(selectedBook, userComment: userComment.text)

                self.dismiss(animated: true)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}
// MARK: - TableView delegate and datasource methods.
extension AddNewBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.bookDataModel.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: - Cell'e tıklanınca yeni sayfada seçilen kitabın özelliklerini vs göster ve kullanıcıdan yorumlarını alıp
        // Onları kaydedip sonrasında da Feed içerisinde göster onları.
        addNewBookToFirebase(selectedBook: indexPath.row)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addNewBookCell", for: indexPath) as? NewBookTableViewCell else { return UITableViewCell() }
        cell.bookName.text = viewModel.bookDataModel[indexPath.row].volumeInfo.title
        cell.authorName.text = viewModel.bookDataModel[indexPath.row].volumeInfo.authors?.first
        if let imageUrl = viewModel.bookDataModel[indexPath.row].volumeInfo.imageLinks?.first?.value {
            cell.bookImage.sd_setImage(with: URL(string: imageUrl))
        }
        return cell
    }
}
// MARK: - UISearchBarDelegate methods.
extension AddNewBookViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.loadData(nil)
            addNewBookTableView.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadData(searchBar.text)
        addNewBookTableView.reloadData()
    }
}

extension AddNewBookViewController: AddNewBookViewModelDelegate {
    func loadDataFromInternet(items: [Items]) {
        addNewBookTableView.reloadData()
    }
}
