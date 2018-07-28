//
//  chatengineTests.swift
//  chatengineTests
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import XCTest
@testable import chatengine

final class MockChatService: ChatService {
    public func connect(username: String, password: String, completion: @escaping ChatManagerConnectCompletion) {
        //completion(.failure(error: NSError(domain: "", code: 0, userInfo: [:])))
        completion(.success(result: true))
    }
}
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
        let mockService = MockChatService()
        let mockDI = DependencyContainer(service: mockService)
        let manager = ChatManager.init(dependencies: mockDI)
        manager.connect(username: username, password: password, completion: { result in
            switch result {
            case .success(let result): XCTAssert(result == true)
            case .failure(let error as NSError): XCTAssert( error.code != 0)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    func testConfigureChatManager() {
        //ChatManager.init(dependencies: DI.ChatManager)
    }
}
