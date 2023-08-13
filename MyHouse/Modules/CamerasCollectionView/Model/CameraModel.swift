//
//  CameraModel.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import Foundation

struct CameraModel: Decodable {
    let success: Bool?
    let data: DataModel
}

struct DataModel: Decodable {
    let room: [String]?
    let cameras: [Camera]
}

struct Camera: Decodable {
    let name: String?
    let snapshot: String?
    let room: String?
    let id: Int?
    let favorites, rec: Bool?
}
