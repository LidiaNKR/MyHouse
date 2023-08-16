//
//  CameraTableViewCell.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

protocol CameraTableViewCellProtocol {
    ///Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - camera: модель массива камер
    func configure(with camera: Camera)
}

final class CameraTableViewCell: UITableViewCell, CameraTableViewCellProtocol {
    
    // MARK: - Public properties
    static let identifier = "cameraCell"
    
    // MARK: - IBOutlets
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var cameraImageView: NetworkImageView!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var recImageView: UIImageView!
    @IBOutlet var guardImageView: UIImageView!

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
