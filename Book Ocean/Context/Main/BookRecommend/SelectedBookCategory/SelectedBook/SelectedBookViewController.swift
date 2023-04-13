//
//  SelectedBookViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import UIKit
import SDWebImage

final class SelectedBookViewController: BaseViewController {

    //MARK: - Outlets.
    @IBOutlet private var selectedBookImageView: UIImageView!
    @IBOutlet private var selectedBookName: UILabel!
    @IBOutlet private var selectedAuthorName: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var selectedBookDesc: UITextView!
    
    //MARK: - Properties.
    var selectedBookVM: SelectedBookViewModel = SelectedBookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveButton.layer.cornerRadius = 25
        guard let selectedBook = selectedBookVM.selectedBook else { return }
        setData(selectedBook)
    }

    private func setData(_ selectedBook: Items) {
        
        if let imageUrl = selectedBook.volumeInfo.imageLinks?.first?.value {
            selectedBookImageView.sd_setImage(with: URL(string: imageUrl))
        }
        
        selectedBookName.text = selectedBook.volumeInfo.title
        selectedAuthorName.text = selectedBook.volumeInfo.authors?.first
        selectedBookDesc.text = selectedBook.volumeInfo.description
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        showAlertWithHandler(messageText: "Book", titleText: "xx") { _ in
            // Bu alana save butonuna basıldıktan sonra seçilen kitabı firebase postala.
        }
    }
}
