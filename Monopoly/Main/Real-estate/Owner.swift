//
//  Owner.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Owner {
    var name: String
    var properties: [Property]
    private var isBroken: Bool
    
    init(name: String) {
        self.name = name
        self.isBroken = false
        self.properties = []
    }
    
    func buyProperty(_ property: Property) {
        properties.append(property)
    }
    
    func sellProperty(_ title: String) {
        properties = properties.filter{ $0.title != title }
    }
    
    func buildHouses(_ number: Int, in title: String) throws -> Int {
        var payment = 0
        for property in properties {
            if property.title == title {
                payment = try property.buildHouses(number)
            }
        }
        return payment
    }
    
    func buildHotels(_ number: Int, in title: String) throws -> Int {
        var payment = 0
        for property in properties {
            if property.title == title {
                payment = try property.buildHouses(number)
            }
        }
        return payment
    }
    
    func mortgageProperty(_ title: String) -> Int {
        var mortgage = 0
        for property in properties {
            if property.title == title {
                mortgage = property.mortgage()
            }
        }
        return mortgage
    }
    
    func unmortgageProperty(_ title: String) -> Int {
        var unmortgage = 0
        for property in properties {
            if property.title == title {
                unmortgage = property.unmortgage()
            }
        }
        return unmortgage
    }
    
    func bankruptcy() -> Int {
        isBroken = true
        let propertiesValue = properties.reduce(0, { result, property in
            return result + property.bankruptcy()
        })
        properties = []
        return propertiesValue
    }
}
