//
//  Utility.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class NoStrataProperty: Property {
    
    var data: PropertyData
    var numberOfHouses: Int
    var hasHotel: Bool
    var mortaged: Bool
    
    required init(data: PropertyData) {
        self.data = data
        self.numberOfHouses = 0
        self.hasHotel = false
        self.mortaged = false
    }

    var title: String {
        return data.title
    }
    
    func mortgage() -> Int {
        mortaged = true
        return data.mortgage
    }
    
    func unmortgage() -> Int {
        mortaged = false
        let value = Double(data.mortgage) * 1.1
        return Int(value.rounded())
    }
    
    func copy() -> Property {
        let copy = NoStrataProperty(data: self.data)
        copy.mortaged = self.mortaged
        return copy
    }
}
