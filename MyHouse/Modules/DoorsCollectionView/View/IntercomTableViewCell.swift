//
//  IntercomTableViewCell.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 13.08.2023.
//

import UIKit

protocol IntercomTableViewCellProtocol {
    ///Дверь открыта? - Да/Нет
//    var doorIsLook: Bool { get }
    
    ///Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - intercom: модель массива дверей
    func configure(with intercom: Door)
}

final class IntercomTableViewCell: UITableViewCell, IntercomTableViewCellProtocol {
    
    // MARK: - Public properties
    static let identifier = "intercomCell"
    var doorIsLook: Bool = true
    
    // MARK: - IBOutlets
    @IBOutlet var cameraImageView: NetworkImageView!
    @IBOutlet var intercomLabel: UILabel!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var lockImageView: UIImageView!

    // MARK: - Public methods
    func configure(with intercom: Door) {
        layer.cornerRadius = 20
        backgroundColor = .white
        cameraImageView.fetchImage(from: intercom.snapshot)
        intercomLabel.text = intercom.name
        favoriteImageView.setVisible(for: favoriteImageView, value: intercom.favorites)
        doorIsLook ?
        (lockImageView.image = #imageLiteral(resourceName: "Lock"))
        : (lockImageView.image = #imageLiteral(resourceName: "Unlock"))
    }
}
