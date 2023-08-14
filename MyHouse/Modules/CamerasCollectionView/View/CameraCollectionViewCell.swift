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
    @IBOutlet weak var cameraImageView: NetworkImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var recImageView: UIImageView!
    @IBOutlet weak var guardImageView: UIImageView!
    
    // MARK: - Public methods
    func configure(with camera: Camera) {
        layer.cornerRadius = 20
        backgroundColor = .white
        cameraLabel.text = camera.name
        cameraImageView.fetchImage(from: camera.snapshot)
        favoriteImageView.setVisible(for: favoriteImageView, value: camera.favorites)
        recImageView.setVisible(for: recImageView, value: camera.rec)
    }
}
