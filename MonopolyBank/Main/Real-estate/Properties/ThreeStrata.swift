//
//  ThreeStrata.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class ThreeStrata: StrataProperty {
    var data: PropertyData
    var numberOfHouses: Int
    var numberOfHotels: Int
    var mortaged: Bool
    var buildingPrice: Int {
        return 150
    }
    
    required init(data: PropertyData) {
        self.data = data
        self.numberOfHotels = 0
        self.numberOfHouses = 0
        self.mortaged = false
    }
}
