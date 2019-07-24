//
//  RealState.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstate {
    private var owners: [Owner]
    var numberOfOwners: Int {
        return owners.count
    }
    
    init() {
        owners = []
    }
    
    func ownerAt(_ position: Int) -> Owner {
        return owners[position]
    }
    
    func addOwner(_ owner: Owner) {
        owners.append(owner)
    }
    
    func property(_ property: Property, ownerName: String) throws {
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
    
    private func owner(for name: String) -> Owner? {
        return owners.filter{ $0.name == name }.first
    }
}

enum RealStateException: Error {
    case buildNotAllowed
    case exceedsBuildsAllowed
    case noBuildsFound
}
