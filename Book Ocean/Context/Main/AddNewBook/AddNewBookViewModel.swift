//
//  AddNewBookViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 26.03.2023.
//

import Foundation

protocol AddNewBookViewModelDelegate: AnyObject {
    func loadDataFromInternet(items: [Items])
}

protocol AddNewBookViewModelProtocol: AnyObject {
    var delegate: AddNewBookViewModelDelegate? { get set }
    func loadData(_ searchedBook: String?)
}

final class AddNewBookViewModel: AddNewBookViewModelProtocol {
    
    
    private var networkManager: NetworkManageer = NetworkManageer()
    private var firebaseManager: FirebaseManager = FirebaseManager()

    var bookDataModel: [Items] = [Items]()
    weak var delegate: AddNewBookViewModelDelegate?

    func loadData(_ searchedBook: String?) {

        var baseUrl = "https://www.googleapis.com/books/v1/volumes?q=*&startIndex=0&maxResults=40"
        
        if let searchedBook {
            baseUrl = "https://www.googleapis.com/books/v1/volumes?q=\(searchedBook)&startIndex=0&maxResults=40"
        }
        
        
        // let apiKey = "AIzaSyChF3sRwYmKnTlUNmCa2pk2QfkRX8O6Zu8"

        // let exampleUrl = "https://www.googleapis.com/books/v1/volumes?q=gogol"
        
        networkManager.service(url: baseUrl) { [weak self] (response: Result<Book, ServiceError>) in
            guard let self = self else { return }
        
            switch response {
            case .success(let data):
                self.bookDataModel = data.items
                self.delegate?.loadDataFromInternet(items: self.bookDataModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    func addNewBookToFirebase(_ selectedBook: Int, userComment: String?) {
        
        // Kayıt işlemi burada yapılacak.
        let takenBook = bookDataModel[selectedBook].volumeInfo
        let category = takenBook.categories?.first
        let firebaseBookModel = FirebaseBookModel(title: takenBook.title ?? "-", description: takenBook.description ?? "-", author: takenBook.authors!.first!, imageLink: takenBook.imageLinks!.first!.value, userComment: userComment!, userEmail: "fakeemail@gmail.com", categories: category ?? "-")
        
        firebaseManager.addNewBookToFirebase(firebaseBookModel)
        
    }
}
