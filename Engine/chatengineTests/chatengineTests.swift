//
//  chatengineTests.swift
//  chatengineTests
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import XCTest
@testable import chatengine


class chatengineTests: XCTestCase {
    
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
        
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        
        
        ChatManager.shared.connect(username: username, password: password, completion: {
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        })
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
        
    }
}
