//
//  BankViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class BankViewModel {
    private var bank: Bank
    var reloadAccounts: (() -> Void)?
    var captureAmountForNewLoanWith: ((_ account: Account, _ completion: @escaping (String?) -> Void) -> Void)?
    
    init() {
        bank = Bank(accounts: [])
    }
    
    var numberOfAccounts: Int {
        return bank.numberOfAccounts
    }
    
    func accountAt(index: Int) -> Account {
        return bank.accountAt(index)
    }
    
    func addAccountFor(_ playerName: String?) {
        guard let name = playerName, !name.isEmpty else {
            return
        }
        bank.addAccount(Account(playerName: name))
        reloadAccounts?()
    }
    
    func loanForAccount(at index: Int) {
        let account = accountAt(index: index)
        captureAmountForNewLoanWith?(account, { [weak self] amount in
            guard let stringAmount = amount, let loanAmount = Int(stringAmount) else {
                return
            }
            self?.loanFor(account: account, with: loanAmount)
            self?.reloadAccounts?()
        })
    }
    
    func payLoanForAccount(at index: Int) {
        let account = accountAt(index: index)
        captureAmountForNewLoanWith?(account, { [weak self] amount in
            guard let stringAmount = amount, let loanAmount = Int(stringAmount) else {
                return
            }
            self?.payLoanFor(account: account, with: loanAmount)
            self?.reloadAccounts?()
        })
    }
    
    private func loanFor(account: Account, with amount: Int) {
        do {
            try bank.addLoan(for: account.playerName, amount: amount)
        } catch {
            print("error ocurred")
        }
    }
    
    private func payLoanFor(account: Account, with amount: Int) {
        do {
            try bank.payLoans(with: amount, forPlayer: account.playerName)
        } catch {
            print("error ocurred")
        }
    }
    
}
