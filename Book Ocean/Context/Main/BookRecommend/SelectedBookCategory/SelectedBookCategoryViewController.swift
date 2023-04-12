//
//  SelectedBookCategoryViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import UIKit

class SelectedBookCategoryViewController: UIViewController {

    //MARK: - Outlets.
    @IBOutlet private var selectedBookCategoryTableView: UITableView!

    //MARK: - Properties.
    var selectedBookCategoryVM: SelectedBookCategoryViewModel = SelectedBookCategoryViewModel()
    
    //MARK: - Life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let takenData = selectedBookCategoryVM.selectedCategory ?? ""
        print("Taken book category: \(takenData)")
    }
}

extension SelectedBookCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected book sayfasına segue yap ve seçilen kitapla alakalı özellikleri göster.
    }
}
