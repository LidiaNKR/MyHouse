//
//  CameraCollectionViewCell.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

protocol CameraCollectionViewCellProtocol {
    ///Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - camera: модель массива камер
    func configure(with camera: Camera)
}

final class CameraCollectionViewCell: UICollectionViewCell, CameraCollectionViewCellProtocol {
    
    // MARK: - Public properties
    static let identifier = "cameraCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var cameraImage: NetworkImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var guardImage: UIImageView!

    // MARK: - Public methods
    func configure(with camera: Camera) {
        layer.cornerRadius = 20
        backgroundColor = .white
        cameraLabel.text = camera.name
        cameraImage.fetchImage(from: camera.snapshot)
        playButton.imageView?.image = #imageLiteral(resourceName: "Play")
    }
}
