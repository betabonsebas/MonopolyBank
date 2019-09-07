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
    var hasHotel: Bool { get set }
    var mortaged: Bool { get set }
    var title: String { get }
    
    init(data: PropertyData)
    
    func mortgage() -> Int
    func unmortgage() -> Int
    func setHouses(_ number: Int) throws
    func setHotel() throws
    
    func copy() -> Property
}

extension Property {
    func setHouses(_ number: Int) throws {
        throw RealStateException.buildNotAllowed
    }
    
    func setHotel() throws {
        throw RealStateException.buildNotAllowed
    }
}

enum RealStateException: Error {
    case buildNotAllowed
    case exceedsBuildsAllowed
    case noBuildsFound
}
