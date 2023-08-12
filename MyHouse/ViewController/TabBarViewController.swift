//
//  TabBarViewController.swift
//  MyHouse
//
//  Created by Лидия Ладанюк on 11.08.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.first?.title = "Камеры"
        viewControllers?.last?.title = "Двери"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
    }
}
