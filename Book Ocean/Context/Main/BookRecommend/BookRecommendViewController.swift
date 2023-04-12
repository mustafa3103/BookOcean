//
//  BookRecommendViewController.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit

final class BookRecommendViewController: UIViewController, Transition {
    

    //MARK: - Outlets.
    @IBOutlet private var bookRecommendTableView: UITableView!
    
    //MARK: - Properties.
    private var viewModel: BookRecommendViewModel = BookRecommendViewModel()
    var selectedCategory: String?
    
    //MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        bookRecommendTableView.register(UINib(nibName: "BookRecommendTableViewCell", bundle: nil), forCellReuseIdentifier: "bookRecommendCell")
    }
}
//MARK: - Tableview delegate and datasource methods.
extension BookRecommendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.takeBookSubjects().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookRecommendCell", for: indexPath) as? BookRecommendTableViewCell else { return UITableViewCell() }
        let subject = (viewModel.takeBookSubjects())[indexPath.row]
        cell.setData(imageName: subject.imageName, subject: subject.subject)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seçilen item'a göre kitap önerisi yap.
        selectedCategory = (viewModel.takeBookSubjects())[indexPath.row].subject
        let storyboard = UIStoryboard(name: "SelectedBookCategory", bundle: nil)
        guard let selectedBookCategoryVC = storyboard.instantiateViewController(withIdentifier: "selectedBookCategory") as? SelectedBookCategoryViewController else { return }
        selectedBookCategoryVC.selectedBookCategoryVM.selectedCategory = selectedCategory
        navigationController?.pushViewController(selectedBookCategoryVC, animated: true)
        // navigatePageWithPush(nameText: "SelectedBookCategory", identifier: "selectedBookCategory", targetVC: SelectedBookViewController(), data: selectedCategory)
        
    }
}
