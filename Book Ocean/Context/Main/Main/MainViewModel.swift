//
//  MainViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func loadedData(takenBooks: [FirebaseBookModel])
}

protocol MainViewModelProtocol: AnyObject {
    func loadData()
}

final class MainViewModel: MainViewModelProtocol {
    
    weak var delegate: MainViewModelDelegate?
    private var firebaseManager: FirebaseManager = FirebaseManager()

    func loadData() {
        firebaseManager.loadDataFromFirebase { takenBooks in
            self.delegate?.loadedData(takenBooks: takenBooks)
        }
    }
}
