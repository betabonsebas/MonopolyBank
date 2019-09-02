//
//  RealState.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstate {
    
    private var propertiesFactory: PropertiesFactory
    private var owners: [Player]
    var numberOfOwners: Int {
        return owners.count
    }
    
    init() {
        propertiesFactory = PropertiesFactory(file: "Properties")
        let bank = Player(name: "Banco")
        bank.properties = propertiesFactory.properties
        owners = [bank]
    }
    
    func ownerAt(_ position: Int) -> Player {
        return owners[position]
    }
    
    func addOwner(_ owner: Player) {
        owners.insert(owner, at: 0)
    }
    
    func buyProperty(_ property: Property, ownerName: String) throws {
        guard let owner = owner(for: ownerName) else {
            throw BankException.accountNotFoundError
        }
        owner.buyProperty(property)
    }
    
    func sellProperty(_ title: String, from ownerName: String) throws {
        guard let owner = owner(for: ownerName) else {
            throw BankException.accountNotFoundError
        }
        owner.sellProperty(title)
    }
    
    func mortgageProperty(_ title: String, from ownerName: String) throws -> Int {
        guard let owner = owner(for: ownerName) else {
            throw BankException.accountNotFoundError
        }
        return owner.mortgageProperty(title)
    }
    
    func unmortgageProperty(_ title: String, from ownerName: String) throws -> Int {
        guard let owner = owner(for: ownerName) else {
            throw BankException.accountNotFoundError
        }
        return owner.unmortgageProperty(title)
    }
    
    func bankruptcyOwner(_ name: String) throws -> Int {
        guard let owner = owner(for: name) else {
            throw BankException.accountNotFoundError
        }
        return owner.bankruptcy()
    }
    
    private func owner(for name: String) -> Player? {
        return owners.filter{ $0.name == name }.first
    }
}

enum RealStateException: Error {
    case buildNotAllowed
    case exceedsBuildsAllowed
    case noBuildsFound
}
