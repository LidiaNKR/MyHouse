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
    private var doorIsLook: Bool = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var bottomSheetContainer: UIView!
    @IBOutlet weak var eyeButtom: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainImageView: NetworkImageView!
    @IBOutlet weak var lockButton: UIButton!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = door?.name
        navigationItem.setHidesBackButton(true, animated: true)
        
        lockButton.layer.cornerRadius = 20
        bottomSheetContainer.layer.cornerRadius = 20
        mainImageView.fetchImage(from: door?.snapshot)
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func openTheDoorButton() {
        doorIsLook.toggle()
    }
}

