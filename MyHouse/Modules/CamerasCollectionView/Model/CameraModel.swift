//
//  CameraModel.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

///Модель данных
struct CameraModel: Decodable {
    let success: Bool
    let data: CameraDataModel
}

///Модель массива комнат и камер
struct CameraDataModel: Decodable {
    let room: [String]
    let cameras: [Camera]
}

///Модель камеры
@objcMembers final class Camera: Object, Decodable {
    dynamic var name: String
    dynamic var snapshot: String
    dynamic var room: String?
    dynamic var id: Int
    dynamic var favorites: Bool
    dynamic var rec: Bool
}
