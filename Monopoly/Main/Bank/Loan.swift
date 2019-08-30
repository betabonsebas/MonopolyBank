//
//  Loan.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Loan {
    private let player: Account
    private var amount: Int
    private var fees: [Int]
    
    init(player: Account, amount: Int) {
        self.player = player
        self.amount = amount
        self.fees = []
    }
    
    var remainingAmount: Int {
        return amount - amountPaid
    }
    
    var playerName: String {
        return player.playerName
    }
    
    func payFeeAndGiveBack(_ fee: Int) -> Int {
        if fee >= remainingAmount {
            let back = fee - remainingAmount
            payAllLoan()
            return back
        }
        
        fees.append(fee)
        return 0
    }
    
    private func payAllLoan() {
        fees.append(remainingAmount)
    }
    
    private var amountPaid: Int {
        return fees.reduce(0, +)
    }
}
