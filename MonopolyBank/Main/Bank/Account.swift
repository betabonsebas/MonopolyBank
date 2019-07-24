//
//  Player.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Account {
    var playerName: String
    private var loans: [Loan]
    
    init(playerName: String) {
        self.playerName = playerName
        self.loans = []
    }
    
    func addLoan(_ amount: Int) {
        loans.append(Loan(player: self, amount: amount))
    }
    
    func payFee(_ fee: Int) {
        var remainingFee = fee
        for loan in loans {
            remainingFee = loan.payFeeAndGiveBack(remainingFee)
        }
    }
    
    func totalLoansAmount() -> Int {
        return loans.reduce(0, { result, loan in
            return result + loan.remainingAmount
        })
    }
}
