//
//  RealStateTests.swift
//  MonopolyBankTests
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import XCTest
@testable import Monopoly

class RealStateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testOwner() {
        let owner = Player(name: "Propietario1")
        XCTAssertEqual(owner.name, "Propietario1")
    }
}
