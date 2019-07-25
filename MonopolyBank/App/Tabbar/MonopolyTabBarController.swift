//
//  MonopolyTabBarController.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla Betancur on 7/24/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation
import UIKit

class MonopolyTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forceViewControllersLoad()
    }
    
    private func forceViewControllersLoad() {
        guard let navigationControllers = self.viewControllers as? [UINavigationController] else {
            return
        }
        for controller in navigationControllers {
            loadViewControllerIn(controller)
        }
    }
    
    private func loadViewControllerIn(_ navigationController: UINavigationController) {
        guard let viewController = navigationController.viewControllers.first else {
            return
        }
        let _ = viewController.view
    }
}
