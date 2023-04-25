//
//  ReadingListViewModel.swift
//  Book Ocean
//
//  Created by Mustafa on 14.04.2023.
//

import Foundation

protocol ReadingListViewModelDelegate: AnyObject {
    func loadedData()
}

protocol ReadingListViewModelProtocol: AnyObject {
    func loadDataFromFirebase()
}
final class ReadingListViewModel: ReadingListViewModelProtocol {
    
    weak var delegate: ReadingListViewModelDelegate?
    var books = [FirebaseBookModel]()
    private var firebaseManager: FirebaseManager = FirebaseManager()
    
    func loadDataFromFirebase() {
//        firebaseManager.loadDataFromFirebase(collection: "SelectedBooks") { selectedBook in
//            self.books = selectedBook
//            self.delegate?.loadedData()
//        }
        firebaseManager.loadReadingList { readingListBooks in
            self.books = readingListBooks
            self.delegate?.loadedData()
        }
    }
}
