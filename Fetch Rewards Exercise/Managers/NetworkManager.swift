//
//  NetworkManager.swift
//  Fetch Rewards Exercise
//
//  Created by Maximo Liriano on 10/20/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        let endpoint = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        guard let url = URL(string: endpoint) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Item].self, from: data)
                completion(.success(items))
                
            } catch {
                print(error)
            }
        }
        
        session.resume()
    }
}
