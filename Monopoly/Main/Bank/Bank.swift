//
//  Bank.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class Bank {
    private var accounts: [Account]
    
    init(accounts: [Account])  {
        self.accounts = accounts
    }
    
    var numberOfAccounts: Int {
        return accounts.count
    }
    
    func accountAt(_ position: Int) -> Account {
        return accounts[position]
    }
    
    func addAccount(_ account: Account) {
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
    
    private func account(for name: String) -> Account? {
        return accounts.filter{ $0.playerName == name }.first
    }
}

enum BankException: Error {
    case accountNotFoundError
    case loanNotFoundError
}
