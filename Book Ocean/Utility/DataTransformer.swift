//
//  DataTransformer.swift
//  Book Ocean
//
//  Created by Mustafa on 11.04.2023.
//

import Foundation

class DataTransferManager {
    
    static let shared = DataTransferManager()
    
    private var dataTransferClosure: ((String) -> Void)?
    
    func setDataTransferClosure(_ closure: @escaping (String) -> Void) {
        self.dataTransferClosure = closure
    }
    
    func transferData(_ data: String) {
        self.dataTransferClosure?(data)
    }
}
