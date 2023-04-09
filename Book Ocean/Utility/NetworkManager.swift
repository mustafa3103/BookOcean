//
//  NetworkManager.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 2.04.2023.
//

import Foundation

enum ServiceError: Error {
    case canNotProcessData
    case noDataAvailable
    case unconvertableURL
}

final class NetworkManageer {

    func service<T: Codable>(url: String, completion: @escaping (Result<T, ServiceError>) -> Void) {
        guard let query = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: query) { data, response, error in
            if error != nil {
                completion(.failure(.unconvertableURL))
            }
            guard let data = data, response != nil else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let returnValue = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(returnValue))
                }
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }.resume()
    }
}
