//
//  NetworkingManager.swift
//  UsersApp
//
//  Created by Maxos on 6/10/23.
//

import Foundation

enum NetworkingManager {
    
    static func fetchData(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://my.api.mockaroo.com/users.json?key=f0ce7b20")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
        
            do {
                let result = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
