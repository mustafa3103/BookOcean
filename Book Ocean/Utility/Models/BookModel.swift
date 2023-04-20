//
//  BookModel.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 2.04.2023.
//

import Foundation

struct Book: Codable {
    var items: [Items]
}

struct Items: Codable {
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    var title: String?
    var subtitle: String?
    var authors: [String]?
    var pageCount: Int?
    var description: String?
    var imageLinks: [String: String]?
    var categories: [String]?
}
