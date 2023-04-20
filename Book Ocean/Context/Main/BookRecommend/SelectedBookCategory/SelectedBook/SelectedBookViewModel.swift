//
//  SelectedBookViewModel.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import Foundation

protocol SelectedBookDelegate: AnyObject {
    func dataIsLoaded()
}

protocol SelectedBookProtocol: AnyObject {
    var delegate: SelectedBookDelegate? { get set }
}

final class SelectedBookViewModel: SelectedBookProtocol {
    
    //MARK: - Properties.
    weak var delegate: SelectedBookDelegate?
    var selectedBook: Items?
    var selectedBookFromFB: FirebaseBookModel?
    
    //MARK: - Private properties.
    private var networkManager: NetworkManageer = NetworkManageer()
    private var firebaseManager: FirebaseManager = FirebaseManager()

    func addSelectedBookToFirebase() {
        guard let selectedBook = selectedBook?.volumeInfo else { return }
        let userEmail = firebaseManager.getCurrentUserEmail()
        let category = selectedBook.categories?.first
        let firebaseBookModel = FirebaseBookModel(title: selectedBook.title ?? "-", description: selectedBook.description ?? "-", author: selectedBook.authors?.first ?? "-", imageLink: selectedBook.imageLinks!.first!.value , userComment: "-", userEmail: userEmail, categories: category ?? "-")
        firebaseManager.addNewBookToFirebase(collection: "SelectedBooks", firebaseBookModel)
    }
}
