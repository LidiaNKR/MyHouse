//
//  DoorModel.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

struct DoorModel: Decodable {
    let success: Bool?
    let data: [DoorDataModel]
}

struct DoorDataModel: Decodable {
    let name: String?
    let snapshot: String?
    let room: String?
    let id: Int?
    let favorites: Bool?
}
