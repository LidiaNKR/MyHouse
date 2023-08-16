//
//  NetworkImageView.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 12.08.2023.
//

import UIKit

protocol NetworkImageViewProtocol {
    /// Установка каринки.
    /// Проверяем есть ли изображение в кеше.
    /// Если нет, грузим из сети по ссылке и сохраняем в кеш.
    /// - Parameters:
    ///   - url: ссылка на картинку
    func fetchImage(from url: String?)
}

final class NetworkImageView: UIImageView, NetworkImageViewProtocol {
    
    // MARK: - Public properties
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let imageNetworkService: ImageNetworkServiceProtocol = ImageNetworkService()
    
    // MARK: - Public methods
    func fetchImage(from url: String?) {
        
        activityIndicator(false)
        
        guard let url = url, let imageURL = URL(string: url) else {
            image = #imageLiteral(resourceName: "DefaultImage")
            self.activityIndicator(true)
            return
        }
        
        /// Используем изображение из кеша, если оно есть
        if let cahcedImage = getCachedImage(from: imageURL) {
            self.activityIndicator(true)
            image = cahcedImage
            return
        }
        
        /// Если изображения в кеше нет, то гризим его из сети
        imageNetworkService.fetchImage(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.activityIndicator(true)
                self.image = UIImage(data: data)
            }
            /// Сохраняем изображение в кеш
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    // MARK: - Private methods
    ///Настройка activityIndicator
    private func activityIndicator(_ isHidden: Bool) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if !isHidden {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    ///Получаем изображение из кеша
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    /// Сохранение изображения в кеш
    private func saveDataToCache(with data: Data, and reponse: URLResponse) {
        guard let urlResponse = reponse.url else { return }
        let urlRequest = URLRequest(url: urlResponse)
        let cachedResponse = CachedURLResponse(response: reponse, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
