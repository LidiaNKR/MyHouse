//
//  ImageNetworkService.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 12.08.2023.
//

import Foundation

protocol ImageNetworkServiceProtocol {
    /// Загрузка изображения из сети.
    /// - Parameters:
    ///   - url: URL фотографии.
    ///   - completion: Обработчик завершения, вызываемый в конце выполнения функции.
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void)
}

final class ImageNetworkService: ImageNetworkServiceProtocol {
    
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard url == response.url else { return }
            completion(data, response)
        }.resume()
    }
}
