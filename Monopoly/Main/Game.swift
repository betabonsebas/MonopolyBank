//
//  Bank.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Game {
    private var _players: [Player]
    private var _properties: [Property]
    
    static let shared = Game()
    
    init()  {
        self._players = []
        self._properties = PropertiesFactory().properties
    }
    
    var players: [Player] {
        return _players
    }
    
    var properties: [Property] {
        let ownedProperties: [Property] = _players.compactMap { $0.properties }.reduce([], +)
        return ownedProperties.count == 0 ? _properties : _properties.filter { (p) -> Bool in
            !ownedProperties.contains(where: { (p1) -> Bool in
                p.data.title == p1.data.title
            })
        }
    }
    
    func addPlayer(_ player: Player) {
        _players.append(player)
    }
}

enum BankException: Error {
    case accountNotFoundError
    case loanNotFoundError
}
