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
    var buttonState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI(buttonState)
        
        
    }

    private func updateUI(_ state: Bool) {
        if state {
            saveButton.isHidden = false
            guard let selectedBook = selectedBookVM.selectedBook else { return }
            
            if let imageUrl = selectedBook.volumeInfo.imageLinks?.first?.value {
                selectedBookImageView.sd_setImage(with: URL(string: imageUrl))
            }

            selectedBookName.text = selectedBook.volumeInfo.title
            selectedAuthorName.text = selectedBook.volumeInfo.authors?.first
            selectedBookDesc.text = selectedBook.volumeInfo.description
        } else {
            saveButton.isHidden = true
            guard let selectedBook = selectedBookVM.selectedBookFromFB else { return }
            
            selectedBookImageView.sd_setImage(with: URL(string: selectedBook.imageLink))
            selectedBookName.text = selectedBook.title
            selectedAuthorName.text = selectedBook.author
            selectedBookDesc.text = selectedBook.description
        }
        saveButton.layer.cornerRadius = 25
    }

    @IBAction private func saveButtonClicked(_ sender: UIButton) {
        guard let selectedBook = selectedBookVM.selectedBook?.volumeInfo else { return }
        showAlertWithHandler(titleText: "You want to save selected book to your list.", messageText: "\(selectedBook.title ?? "")", cancelButtonActive: true) { _ in
            self.selectedBookVM.addSelectedBookToFirebase()
        }
    }
}
