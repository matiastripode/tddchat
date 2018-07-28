//
//  DelegateToClosureTests.swift
//  tddchatTests
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation
import XCTest

protocol TodoDelegate: class {
    func completed(todo: Todo)
}

typealias Completion = () -> Void

class AnotherTodo: TodoDelegate {
    var completion: Completion?
    var todo: Todo?
    init () {
        self.todo = Todo(self, identifier: 1, title: "")
    }
    func completed(todo: Todo) {
        print("AnotherTodo - completed - TodoDelegate")
        self.completion?()
    }
    func send(message: String, completion: @escaping Completion) {
        print("AnotherTodo - send")
        self.completion = completion
        self.todo?.asyncTask()
    }
}

class Todo {
    var identifier: Int
    var title: String
    var completed: Bool = false {
        didSet {
            // Notify delegate of completion
            guard completed else { return }
            delegate?.completed(todo: self)
        }
    }
    weak var delegate: TodoDelegate?
    init(_ delegate: TodoDelegate, identifier: Int, title: String) {
        self.delegate = delegate
        self.identifier = identifier
        self.title = title
    }
    func asyncTask() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) { [weak self] in
            if let strongSelf = self {
                strongSelf.completed = true
            }
        }
    }
}

class DelegateToClosureTests: XCTestCase {
    func testSimpleTest() {
        let expectation = XCTestExpectation(description: "ChatManager: connect")
        let anotherTodo = AnotherTodo()
        anotherTodo.send(message: "") {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
