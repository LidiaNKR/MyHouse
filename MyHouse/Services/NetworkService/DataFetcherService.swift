//
//  DataFetcherService.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

protocol DataFetcherServiceProtocol {
    ///Получение дверей
    /// - Parameters:
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchDoor(completion: @escaping (DoorModel?) -> Void)
    
    /// Получение камер.
    /// - Parameters:
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchCamera(completion: @escaping (CameraModel?) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    var networkDataFetcher: NetworkDataFetcherProtocol
    
    init(networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchCamera(completion: @escaping (CameraModel?) -> Void) {
        guard let url = APIURL.camerasURL else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func fetchDoor(completion: @escaping (DoorModel?) -> Void) {
        guard let url = APIURL.doorsURL else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
}
