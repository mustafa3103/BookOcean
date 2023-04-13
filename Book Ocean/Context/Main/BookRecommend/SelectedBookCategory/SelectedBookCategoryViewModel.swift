//
//  SelectedBookCategoryViewModel.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import Foundation

protocol SelectedBookCategoryDelegate: AnyObject {
    func dataIsLoaded()
}

protocol SelectedBookCategoryProtocol: AnyObject {
    var delegate: SelectedBookCategoryDelegate? { get set }
    func loadData()
}

final class SelectedBookCategoryViewModel: SelectedBookCategoryProtocol {
    
    weak var delegate: SelectedBookCategoryDelegate?
    var bookDataModel: [Items] = [Items]()
    var selectedCategory: String?
    private var networkManager: NetworkManageer = NetworkManageer()
    
    func loadData() {
        let urlWithCategory =  "https://www.googleapis.com/books/v1/volumes?q=subject:\(selectedCategory ?? "")&startIndex=0&maxResults=40"
        networkManager.service(url: urlWithCategory) { [weak self] (response: Result<Book, ServiceError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                self.bookDataModel = data.items
                self.delegate?.dataIsLoaded()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
}
