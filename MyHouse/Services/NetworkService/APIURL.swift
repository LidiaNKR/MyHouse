//
//  APIURL.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

enum APIURL {
    ///URL- ссылка для получения дверей
    static let doorsURL = URL(string: "https://cars.cprogroup.ru/api/rubetek/doors/")
    
    ///URL- ссылка для получения камер
    static let camerasURL = URL(string: "https://cars.cprogroup.ru/api/rubetek/cameras/")
}
