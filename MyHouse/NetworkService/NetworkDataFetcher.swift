//
//  NetworkDataFetcher.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    ///Получение общих данных по URL
    /// - Parameters:
    ///   - url: URL запроса.
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (Result<T?, Error>) -> Void)
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkServiceProtocol
    
    init(networking: NetworkServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (Result<T?, Error>) -> Void) {
        networking.request(url: url) { (data, _, error) in
            guard let data = data else {
                print("Receive HTTP response error")
                return
            }
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                    print(result)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
