//
//  FavoriteImageView.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 14.08.2023.
//

import UIKit

extension UIImageView {
    func setVisible(for image: UIImageView, value: Bool) {
        if value {
            image.isHidden = false
        } else {
            image.isHidden = true
        }
    }
}
