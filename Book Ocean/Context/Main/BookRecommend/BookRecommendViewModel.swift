//
//  BookRecommendViewModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import Foundation

protocol BookRecommendViewModelProtocol: AnyObject {
    func takeBookSubjects() -> [BookRecommendModel]
}

final class BookRecommendViewModel: BookRecommendViewModelProtocol {
    
    func takeBookSubjects() -> [BookRecommendModel] {
        let fear = BookRecommendModel(imageName: "fear", subject: "Fear")
        let love = BookRecommendModel(imageName: "love", subject: "Love")
        let action = BookRecommendModel(imageName: "action", subject: "Action")
        let science = BookRecommendModel(imageName: "science", subject: "Science")
        let life = BookRecommendModel(imageName: "life", subject: "Life")
        let information = BookRecommendModel(imageName: "information", subject: "Information")
        let biography = BookRecommendModel(imageName: "biography", subject: "Biography")
        let subjects: [BookRecommendModel] = [fear, love, action, science, life, information, biography]
        
        return subjects
    }
}
