//
//  UITabbar+Monopoly.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla Betancur on 7/24/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var size = super.sizeThatFits(size)
        size.height = 70
        return size
    }
}
