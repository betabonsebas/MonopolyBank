//
//  Loan.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Loan {
    private var amount: Int
    private var fees: [Int]
    
    init(amount: Int) {
        self.amount = amount
        self.fees = []
    }
    
    var remainingAmount: Int {
        return amount - amountPaid
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
