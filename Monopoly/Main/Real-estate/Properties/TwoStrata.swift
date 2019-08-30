//
//  TwoStrata.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class TwoStrata: StrataProperty {
    var data: PropertyData
    var numberOfHouses: Int
    var numberOfHotels: Int
    var mortaged: Bool
    var buildingPrice: Int {
        return 100
    }
    
    required init(data: PropertyData) {
        self.data = data
        self.numberOfHotels = 0
        self.numberOfHouses = 0
        self.mortaged = false
    }
}