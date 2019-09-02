//
//  Bank.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Game {
    var accounts: [Player]
    
    init()  {
        self.accounts = []
    }
    
    func addAccount(_ account: Player) {
        accounts.append(account)
    }
    
    func addLoan(for playerName: String, amount: Int) throws {
        guard let account = account(for: playerName) else {
            throw BankException.accountNotFoundError
        }
        account.addLoan(amount)
    }
    
    func payLoans(with fee: Int, forPlayer playerName: String) throws {
        guard let account = account(for: playerName) else {
            throw BankException.accountNotFoundError
        }
        
        account.payFee(fee)
    }
    
    func loansAmountFor(_ playerName: String) throws -> Int? {
        guard let account = account(for: playerName) else {
            throw BankException.accountNotFoundError
        }
        
        return account.totalLoansAmount()
    }
    
    private func account(for name: String) -> Player? {
        return accounts.filter{ $0.name == name }.first
    }
}

enum BankException: Error {
    case accountNotFoundError
    case loanNotFoundError
}
