//
//  RealEstateViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class PropertiesViewModel {
    private var properties: [Property]
    
    init(properties: [Property]) {
        self.properties = properties
    }
    
    func numberOfProperties() -> Int {
        return properties.count
    }
    
    func itemAt(index: Int) -> Property {
        return properties[index]
    }
}
