//
//  Player.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Player {
    private var loans: [Loan]
    
    var isBroken: Bool
    var name: String
    var properties: [Property]
    
    
    init(name: String) {
        self.name = name
        self.isBroken = false
        self.loans = []
        self.properties = []
    }
    
    func addLoan(_ amount: Int) {
        loans.append(Loan(amount: amount))
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
    
    func buyProperty(_ property: Property) {
        properties.append(property)
    }
    
    func sellProperty(_ title: String) {
        properties = properties.filter{ $0.title != title }
    }
    
    func bankruptcy() -> Int {
        isBroken = true
        let propertiesValue = properties.reduce(0, { result, property in
            return result + property.mortgage()
        })
        properties = []
        return propertiesValue
    }
}
