//
//  CameraModel.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

struct CameraModel: Decodable {
    let success: Bool
    let data: CameraDataModel
}

struct CameraDataModel: Decodable {
    let room: [String]
    let cameras: [Camera]
}

@objcMembers final class Camera: Object, Decodable {
    dynamic var name: String
    dynamic var snapshot: String
    dynamic var room: String?
    dynamic var id: Int
    dynamic var favorites: Bool
    dynamic var rec: Bool
}
