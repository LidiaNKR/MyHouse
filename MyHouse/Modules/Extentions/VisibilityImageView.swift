//
//  FavoriteImageView.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 14.08.2023.
//

import UIKit

extension UIImageView {
    ///Установка значения картинки, скрыта? - Да/Нет
    /// - Parameters:
    ///   - image: картинка
    ///   - value: устанавливаемое значение
    func setVisible(for image: UIImageView, value: Bool) {
        if value {
            image.isHidden = false
        } else {
            image.isHidden = true
        }
    }
}
