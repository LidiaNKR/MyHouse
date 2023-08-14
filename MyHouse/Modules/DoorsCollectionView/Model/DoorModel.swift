//
//  DoorModel.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

struct DoorModel: Decodable {
    let success: Bool
    let data: [Door]
}

@objcMembers final class Door: Object, Decodable {
    dynamic var name: String
    dynamic var room: String?
    dynamic var id: Int
    dynamic var favorites: Bool
    dynamic var snapshot: String?
}
