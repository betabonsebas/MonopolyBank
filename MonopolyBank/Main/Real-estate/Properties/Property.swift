//
//  Property.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

protocol Property: class {
    var data: PropertyData { get }
    var numberOfHouses: Int { get set }
    var numberOfHotels: Int { get set }
    var mortaged: Bool { get set }
    
    init(data: PropertyData)
    
    var color: String { get }
    var title: String { get }
    
    func bankruptcy() -> Int
    func mortgage() -> Int
    func unmortgage() -> Int
    
    func buildHouses(_ number: Int) throws -> Int
    func buildHotels(_ number: Int) throws -> Int
    
    func sellHouses(_ number: Int) throws -> Int
    func sellHotels(_ number: Int) throws -> Int
}

extension Property {
    var color: String {
        return data.color
    }
    
    var title: String {
        return data.title
    }
    
    func bankruptcy() -> Int {
        return 0
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
    
    func buildHouses(_ number: Int) throws -> Int {
        throw RealStateException.buildNotAllowed
    }
    
    func buildHotels(_ number: Int) throws -> Int {
        throw RealStateException.buildNotAllowed
    }
    
    func sellHouses(_ number: Int) throws -> Int {
        throw RealStateException.noBuildsFound
    }
    
    func sellHotels(_ number: Int) throws -> Int {
        throw RealStateException.noBuildsFound
    }
}
