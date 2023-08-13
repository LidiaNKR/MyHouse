//
//  DoorsCollectionViewCell.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 13.08.2023.
//

import UIKit

protocol DoorCollectionViewCellProtocol {
    ///Идентификатор ячейки двери
//    static var identifier: String { get }
    
    ///Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - door: модель массива дверей
    func configure(with door: Door)
}

final class DoorCollectionViewCell: UICollectionViewCell, DoorCollectionViewCellProtocol {
    
    // MARK: - Public properties
    static let identifier = "doorCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var cameraImage: NetworkImageView!
    @IBOutlet weak var doorTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var lockImage: UIImageView!

    // MARK: - Public methods
    func configure(with door: Door) {
        layer.cornerRadius = 20
        backgroundColor = .white
        cameraImage.fetchImage(from: door.snapshot)
        doorTextField.text = door.name
        playButton.imageView?.image = #imageLiteral(resourceName: "Play")
        lockImage.image = #imageLiteral(resourceName: "Key")
    }
}
