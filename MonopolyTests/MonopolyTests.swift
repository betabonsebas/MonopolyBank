//
//  MonopolyTests.swift
//  MonopolyTests
//
//  Created by Sebastian Bonilla Betancur on 8/30/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import XCTest
@testable import Monopoly

class MonopolyTests: XCTestCase {
    
    var player1: Player!
    var player2: Player!
    var player3: Player!
    var player4: Player!
    var game: Game!
    
    override func setUp() {
        player1 = Player(name: "Player1")
        player2 = Player(name: "Player2")
        player3 = Player(name: "Player3")
        player4 = Player(name: "Player4")
        game = Game(accounts: [player1, player2, player3, player4])
    }
    
    func testCreatePlayer() {
        XCTAssertEqual(player1.name, "Player1")
    }
    
    func testCreateLoan() {
        let loan = Loan(amount: 100)
        XCTAssertEqual(loan.remainingAmount, 100)
    }
    
    func testCreateGame() {
        XCTAssertEqual(game.numberOfAccounts, 4)
    }
    
    func testAddLoanToPlayerThrowingError() {
        XCTAssertThrowsError(try game.addLoan(for: "player", amount: 100), "") { error in
            XCTAssertEqual(error as! BankException, BankException.accountNotFoundError)
        }
    }
    
    func testAddLoanToPlayerWithoutError() {
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 100), "")
        let amount = try! game.loansAmountFor("Player1")
        XCTAssertEqual(amount, 100)
    }
    
    func testAddMultipleLoansToPlayer() {
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 300), "")
        let amount = try! game.loansAmountFor("Player1")
        XCTAssertEqual(amount, 400)
    }
    
    func testPayLoanForPlayerThrowingError() {
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 100), "")
        XCTAssertThrowsError(try game.payLoans(with: 50, forPlayer: "player"), "") { error in
            XCTAssertEqual(error as! BankException, BankException.accountNotFoundError)
        }
    }
    
    func testPayMultipleLoansForPlayer() {
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 250), "")
        XCTAssertNoThrow(try game.payLoans(with: 300, forPlayer: "Player1"), "")
        XCTAssertEqual(try! game.loansAmountFor("Player1"), 50)
    }
    
    func testPayLoanForPlayerWithoutError() {
        XCTAssertNoThrow(try game.addLoan(for: "Player1", amount: 100), "")
        XCTAssertNoThrow(try game.payLoans(with: 50, forPlayer: "Player1"))
        XCTAssertEqual(try! game.loansAmountFor("Player1"), 50)
    }
    
}
