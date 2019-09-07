//
//  BankViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class PlayerViewModel {
    private var game: Game
    var reloadAccounts: (() -> Void)?
    
    init() {
        game = Game.shared
    }
    
    var numberOfPlayers: Int {
        return game.players.count
    }
    
    func playerAt(index: Int) -> Player {
        return game.players[index]
    }
    
    func addAccountFor(_ playerName: String?) {
        guard let name = playerName, !name.isEmpty else {
            return
        }
        game.addPlayer(Player(name: name))
        reloadAccounts?()
    }
    
    func detailViewModelFor(index: Int) -> PlayerDetailViewModel {
        let player = playerAt(index: index)
        return PlayerDetailViewModel(player: player)
    }
    
}
