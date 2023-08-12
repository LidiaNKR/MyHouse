//
//  DescriptionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet var lockButton: UIButton!
    @IBOutlet var keyImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        lockButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func openTheDoorButton(_ sender: Any) {
        
    }
    

}

