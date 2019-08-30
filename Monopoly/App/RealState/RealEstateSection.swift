//
//  RealEstateSection.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstateSection {
    private var owner: Owner
    
    var properties: [Property] {
        return owner.properties
    }
    
    var title: String {
        return owner.name
    }
    
    init(owner: Owner) {
        self.owner = owner
    }
}