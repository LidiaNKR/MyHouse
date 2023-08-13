//
//  DescriptionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {

    // MARK: - Public properties
    var door: Door?
    
    // MARK: - IBOutlets
    @IBOutlet weak var BottomSheetContainer: UIView!
    @IBOutlet weak var mainImageView: NetworkImageView!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var keyImageView: UIImageView!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        lockButton.layer.cornerRadius = 20
        
        mainImageView.fetchImage(from: door?.snapshot)
        navigationItem.title = door?.name
    }
    
    // MARK: - IBActions
    @IBAction func openTheDoorButton() {
    }
}

