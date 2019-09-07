//
//  StrataProperty.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class StrataProperty: Property {
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
        if mortaged {
            return 0
        } else {
            mortaged = true
            let propertiesValue = housesValue + hotelValue
            hasHotel = false
            numberOfHouses = 0
            return data.mortgage + propertiesValue
        }
    }
    
    func unmortgage() -> Int {
        mortaged = false
        return data.mortgage + mortgageInterest
    }
    
    func setHouses(_ number: Int) throws {
        numberOfHouses = number
    }
    
    func setHotel() throws {
        if hasHotel {
            numberOfHouses = 4
        } else {
            guard numberOfHouses == 4 else {
                throw RealStateException.buildNotAllowed
            }
            numberOfHouses = 0
        }
        hasHotel = !hasHotel
    }
    
    private var mortgageInterest: Int {
        let value = Double(data.mortgage) * 1.1
        return Int(value.rounded())
    }
    
    private var housesValue: Int {
        return numberOfHouses * data.buildingSellPrice
    }
    
    private var hotelValue: Int {
        return data.buildingSellPrice + (data.buildingSellPrice * 4)
    }
    
    func copy() -> Property {
        let copy = StrataProperty(data: self.data)
        copy.hasHotel = self.hasHotel
        copy.numberOfHouses = self.numberOfHouses
        copy.mortaged = self.mortaged
        return copy
    }
}
