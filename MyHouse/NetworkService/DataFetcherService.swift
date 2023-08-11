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
    func fetchDoor(completion: @escaping (Result<DoorModel?, Error>) -> Void)
    
    /// Получение камер.
    /// - Parameters:
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchCamera(completion: @escaping (Result<CameraModel?, Error>) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    var networkDataFetcher: NetworkDataFetcherProtocol
    
    init(networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchDoor(completion: @escaping (Result<DoorModel?, Error>) -> Void) {
        guard let url = APIURL.doorsURL else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func fetchCamera(completion: @escaping (Result<CameraModel?, Error>) -> Void) {
        guard let url = APIURL.doorsURL else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
}
