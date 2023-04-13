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
    
    weak var delegate: SelectedBookDelegate?
    var selectedBook: Items?
    private var networkManager: NetworkManageer = NetworkManageer()
}
