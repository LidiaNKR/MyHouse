//
//  ContainerViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    // MARK: - Private properties
    private var currentScreen: CurrentScreenModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var doorContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var underLineView: UIView!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        currentScreen = .left
        doorContainerView.isHidden = true
    }
    
    // MARK: - IBActions
    @IBAction func showCamerasViewController() {
        guard let cameraContainerView = self.cameraContainerView,
              let doorContainerView = self.doorContainerView,
              let underLineView = self.underLineView,
              let containerView = self.containerView
        else { return }
        
        if currentScreen != .left {
            cameraContainerView.isHidden = false
            doorContainerView.isHidden = true
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping:0.95,
                initialSpringVelocity: 0,
                options: [.curveEaseInOut],
                animations: {
                    cameraContainerView.frame.origin.x = 0
                    doorContainerView.frame.origin.x = self.view.frame.size.width
                    underLineView.frame.origin.x = underLineView.frame.origin.x - containerView.frame.size.width / 2
                }
            )
            currentScreen = .left
        }
    }
    
    @IBAction func showDoorsViewController() {
        guard let cameraContainerView = self.cameraContainerView,
              let doorContainerView = self.doorContainerView,
              let underLineView = self.underLineView,
              let containerView = self.containerView
        else { return }
        
        if currentScreen != .right {
            cameraContainerView.isHidden = true
            doorContainerView.isHidden = false
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.95,
                initialSpringVelocity: 0,
                options: [.curveEaseInOut],
                animations: {
                    cameraContainerView.frame.origin.x = -self.view.frame.size.width
                    doorContainerView.frame.origin.x = 0
                    underLineView.frame.origin.x = underLineView.frame.origin.x + containerView.frame.size.width / 2
                }
            )
            currentScreen = .right
        }
    }
}
