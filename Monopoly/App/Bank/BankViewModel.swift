//
//  BankViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class BankViewModel {
    private var bank: Game
    var reloadAccounts: (() -> Void)?
    var captureAmountForNewLoanWith: ((_ account: Player, _ completion: @escaping (String?) -> Void) -> Void)?
    
    init() {
        bank = Game(accounts: [])
    }
    
    var numberOfAccounts: Int {
        return bank.numberOfAccounts
    }
    
    func accountAt(index: Int) -> Player {
        return bank.accountAt(index)
    }
    
    func addAccountFor(_ playerName: String?) {
        guard let name = playerName, !name.isEmpty else {
            return
        }
        bank.addAccount(Player(name: name))
        NotificationCenter.default.post(name: .bankCreateAccount, object: nil, userInfo: ["name": name])
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
    
    private func loanFor(account: Player, with amount: Int) {
        do {
            try bank.addLoan(for: account.name, amount: amount)
        } catch {
            print("error ocurred")
        }
    }
    
    private func payLoanFor(account: Player, with amount: Int) {
        do {
            try bank.payLoans(with: amount, forPlayer: account.name)
        } catch {
            print("error ocurred")
        }
    }
    
}
