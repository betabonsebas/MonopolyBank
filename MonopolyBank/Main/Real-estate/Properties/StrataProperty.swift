//
//  StrataProperty.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

protocol StrataProperty: Property {
    var buildingPrice: Int { get }
    var buildingSellPrice: Int { get }
}

extension StrataProperty {
    var buildingSellPrice: Int {
        return buildingPrice/2
    }
    
    func bankruptcy() -> Int {
        let propertiesValue = housesValue + hotelsValue
        numberOfHotels = 0
        numberOfHouses = 0
        return propertiesValue
    }
    
    func mortgage() -> Int {
        mortaged = true
        let propertiesValue = housesValue + hotelsValue
        numberOfHotels = 0
        numberOfHouses = 0
        return data.mortgage + propertiesValue
    }
    
    func buildHouses(_ number: Int) throws -> Int {
        if number > 4 || numberOfHouses == 4 || (numberOfHouses + number) > 4 || numberOfHotels > 0 {
            throw RealStateException.exceedsBuildsAllowed
        }
        
        numberOfHouses += number
        return number * buildingPrice
    }
    
    func buildHotels(_ number: Int) throws -> Int {
        if number > 1 || numberOfHotels > 0 {
            throw RealStateException.exceedsBuildsAllowed
        }
        
        if numberOfHouses < 4 {
            throw RealStateException.noBuildsFound
        }
        
        numberOfHouses = 0
        numberOfHotels += number
        return number * buildingPrice
    }
    
    func sellHouses(_ number: Int) throws -> Int {
        if number > numberOfHouses {
            throw RealStateException.noBuildsFound
        }
        
        numberOfHouses -= number
        return number * buildingSellPrice
    }
    
    func sellHotels(_ number: Int) throws -> Int {
        if number > numberOfHotels {
            throw RealStateException.noBuildsFound
        }
        
        numberOfHotels -= number
        return number * (buildingSellPrice + (buildingSellPrice * 4))
    }
    
    private var housesValue: Int {
        return numberOfHouses * buildingSellPrice
    }
    
    private var hotelsValue: Int {
        return numberOfHotels * (buildingSellPrice + (buildingSellPrice * 4))
    }
}
