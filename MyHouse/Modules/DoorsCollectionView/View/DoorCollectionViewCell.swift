//
//  DoorCollectionViewCell.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 14.08.2023.
//

import UIKit

protocol DoorCollectionViewCellProtocol {
    ///Дверь открыта? - Да/Нет
    var doorIsLook: Bool { get }
    
    ///Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - door: модель массива дверей
    func configure(with door: Door)
}

final class DoorCollectionViewCell: UICollectionViewCell, DoorCollectionViewCellProtocol {
    // MARK: - Public properties
    static let identifier = "doorCell"
    var doorIsLook: Bool = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var doorLabel: UILabel!
    
    // MARK: - Public methods
    func configure(with door: Door) {
        layer.cornerRadius = 20
        doorLabel.text = door.name
        doorIsLook ? (lockImageView.image = #imageLiteral(resourceName: "Lock")) : (lockImageView.image = #imageLiteral(resourceName: "Unlock"))
    }
}
