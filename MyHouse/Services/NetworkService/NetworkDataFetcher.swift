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
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkServiceProtocol
    
    init(networking: NetworkServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        networking.request(url: url) { (data, error) in
            guard let data = data else {
                print("Receive HTTP response error")
                return
            }
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
