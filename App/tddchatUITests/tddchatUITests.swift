//
//  tddchatUITests.swift
//  tddchatUITests
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import XCTest

class TddChatUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        XCUIApplication().launch()
    }
    override func tearDown() {
        super.tearDown()
    }
}
