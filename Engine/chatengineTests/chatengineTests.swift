//
//  chatengineTests.swift
//  chatengineTests
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import XCTest
@testable import chatengine

class ChatEngineTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testChatManagerConnect() {
        let username = ""
        let password = ""
        let expectation = XCTestExpectation(description: "ChatManager: connect")
        ChatManager.shared.connect(username: username, password: password, completion: { result in
            switch result {
            case .success(let result): XCTAssert(result == true)
            case .failure(let error as NSError): XCTAssert( error.code != 0)
            }
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        })
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
}
