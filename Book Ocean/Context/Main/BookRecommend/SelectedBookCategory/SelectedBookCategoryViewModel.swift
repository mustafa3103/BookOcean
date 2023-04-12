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
    func loadData(_ category: String)
}

final class SelectedBookCategoryViewModel: SelectedBookCategoryProtocol {
    
    weak var delegate: SelectedBookCategoryDelegate?
    var bookDataModel: [Items] = [Items]()
    var selectedCategory: String?
    private var networkManager: NetworkManageer = NetworkManageer()
    
    func loadData(_ category: String) {
        let urlWithCategory =  "https://www.googleapis.com/books/v1/volumes?q=subject:\(category)&startIndex=0&maxResults=40"
        
    }
}
