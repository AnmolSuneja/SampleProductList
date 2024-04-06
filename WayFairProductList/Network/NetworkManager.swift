//
//  NetworkManager.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import Foundation

enum NetworkError: Error {
    case invalidEndpoint
    case systemError(error: String)
    case invalidResponse
    case apiError(code: Int)
    case decodingError
}

class NetworkManager {
    private init() {
        
    }
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        //update instance for any properies if required
        return instance
    }()
    
    func fetchProductList(endpoint: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        makeGetApiHit(endpoint: endpoint, completion: completion)
    }
}

extension NetworkManager {
    func makeGetApiHit<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidEndpoint))
            return
        }
        
        let urlRequest = URLRequest(url: url, timeoutInterval: 60)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.systemError(error: error?.localizedDescription ?? "Some error occured. Please contact administrator")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.apiError(code: response.statusCode)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
