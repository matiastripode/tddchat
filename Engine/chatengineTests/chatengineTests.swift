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
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5.0) {
            completion(.success(result: true))
        }
    }
    public func send(message: String, toContact: String, completion: @escaping ChatManagerSendCompletion) {
        //let error = NSError(domain: "Failed to send message", code: -1, userInfo: ["Send": 1])
        //completion(.failure(error: error))
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5.0) {
            completion(.success(result: true))
        }
    }
    public func receive(completion: @escaping ChatManagerReceiveMessage) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5.0) {
            let message = Message(message: "Message", messageSender: .someoneElse, username: "another@gmail.com")
            completion(.success(result: message))
        }
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
    // Connect to chat
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
    // Send Message
    func testChatManagerSendMessage() {
        let expectation = XCTestExpectation(description: "Send")
        let message = ""
        let contact = ""
        let mockService = MockChatService()
        let mockDI = DependencyContainer(service: mockService)
        let manager = ChatManager.init(dependencies: mockDI)
        manager.send(message: message, toContact: contact) { result in
            switch result {
            case .success(let result): XCTAssert(result == true)
            case .failure(let error as NSError): XCTAssert(error.code != 0)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // Receive Message
    func testChatManagerReceiveMessage() {
        let expectation = XCTestExpectation(description: "Send")
        let mockService = MockChatService()
        let mockDI = DependencyContainer(service: mockService)
        let manager = ChatManager.init(dependencies: mockDI)
        manager.receive { result in
            switch result {
            case .success(let message): XCTAssert(message.message == "Message")
            case .failure(let error as NSError): XCTAssert(error.code != 0)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 14.0)
    }
}
