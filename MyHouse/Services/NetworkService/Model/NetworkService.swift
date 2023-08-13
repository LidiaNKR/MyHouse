//
//  NetworkService.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    ///Запрос данных по URL
    /// - Parameters:
    ///   - url: URL запроса.
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Data?, Error?) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(
            with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
        )
    }
}
