//
//  MonopolyBankTests.swift
//  MonopolyBankTests
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import XCTest
@testable import MonopolyBank

class MonopolyBankTests: XCTestCase {

    var player1: Account!
    var player2: Account!
    var player3: Account!
    var player4: Account!
    var bank: Bank!
    
    override func setUp() {
        player1 = Account(playerName: "Player1")
        player2 = Account(playerName: "Player2")
        player3 = Account(playerName: "Player3")
        player4 = Account(playerName: "Player4")
        bank = Bank(accounts: [player1, player2, player3, player4])
    }
    
    func testCreatePlayer() {
        XCTAssertEqual(player1.playerName, "Player1")
    }
    
    func testCreateLoan() {
        let loan = Loan(player: player1, amount: 100)
        XCTAssertEqual(loan.playerName, player1.playerName)
        XCTAssertEqual(loan.remainingAmount, 100)
    }
    
    func testCreateGame() {
        XCTAssertEqual(bank.numberOfAccounts, 4)
    }
    
    func testAddLoanToPlayerThrowingError() {
        XCTAssertThrowsError(try bank.addLoan(for: "player", amount: 100), "") { error in
            XCTAssertEqual(error as! BankException, BankException.accountNotFoundError)
        }
    }
    
    func testAddLoanToPlayerWithoutError() {
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 100), "")
        let amount = try! bank.loansAmountFor("Player1")
        XCTAssertEqual(amount, 100)
    }
    
    func testAddMultipleLoansToPlayer() {
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 300), "")
        let amount = try! bank.loansAmountFor("Player1")
        XCTAssertEqual(amount, 400)
    }
    
    func testPayLoanForPlayerThrowingError() {
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 100), "")
        XCTAssertThrowsError(try bank.payLoans(with: 50, forPlayer: "player"), "") { error in
            XCTAssertEqual(error as! BankException, BankException.accountNotFoundError)
        }
    }
    
    func testPayMultipleLoansForPlayer() {
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 250), "")
        XCTAssertNoThrow(try bank.payLoans(with: 300, forPlayer: "Player1"), "")
        XCTAssertEqual(try! bank.loansAmountFor("Player1"), 50)
    }
    
    func testPayLoanForPlayerWithoutError() {
        XCTAssertNoThrow(try bank.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try bank.payLoans(with: 50, forPlayer: "Player1"))
        XCTAssertEqual(try! bank.loansAmountFor("Player1"), 50)
    }
    
}
