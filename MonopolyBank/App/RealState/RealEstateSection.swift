//
//  RealEstateSection.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstateSection {
    var properties: [Property]
    var title: String
    
    init(properties: [Property], title: String) {
        self.properties = properties
        self.title = title
    }
}
