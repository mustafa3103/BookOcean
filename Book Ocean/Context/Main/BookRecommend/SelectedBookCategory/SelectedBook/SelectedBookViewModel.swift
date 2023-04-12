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
    func loadData(_ category: String)
}

final class SelectedBookViewModel: SelectedBookProtocol {
    
    weak var delegate: SelectedBookDelegate?
    var bookDataModel: [Items] = [Items]()
    private var networkManager: NetworkManageer = NetworkManageer()
    
    func loadData(_ category: String) {
        let urlWithCategory =  "https://www.googleapis.com/books/v1/volumes?q=subject:\(category)&startIndex=0&maxResults=40"
        
    }
}
