//
//  ChatManager.swift
//  chatengine
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation

public enum  ChatManagerResult<T> {
    case success(result: T)
    case failure(error: Error)
}
public typealias ChatManagerConnectCompletion =  (ChatManagerResult<Bool>) -> Void
public typealias ChatManagerReceiveMessage =  (ChatManagerResult<Message>) -> Void
public typealias ChatManagerSendCompletion =  (ChatManagerResult<Bool>) -> Void

public protocol ChatService {
    func connect(username: String, password: String, completion: @escaping  ChatManagerConnectCompletion)
    func send(message: String, toContact: String, completion: @escaping ChatManagerSendCompletion)
    func receive(completion: @escaping ChatManagerReceiveMessage)
}
public final class ChatManager: ChatService {
    private let dependencies: DependencyContainer
    public init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
    }
    public func connect(username: String, password: String, completion:  @escaping ChatManagerConnectCompletion) {
        let userNameGood = Checker.userName(username: username) == .userNameGood
        let passwordGood = Checker.password(password: password) == .passwordGood
        if userNameGood && passwordGood {
            dependencies.service.connect(username: username, password: password, completion: completion)
        } else {
            let error = NSError(domain: "", code: 1, userInfo: [:])
            completion(.failure(error: error))
        }
    }
    public func send(message: String, toContact: String, completion: @escaping ChatManagerSendCompletion) {
        dependencies.service.send(message: message, toContact: toContact, completion: completion)
    }
    public func receive(completion: @escaping ChatManagerReceiveMessage) {
        dependencies.service.receive(completion: completion)
    }
}
enum CheckUsernameResult {
    case userNameGood
}
enum CheckPasswordResult {
    case passwordGood
}
struct Checker {
    static func userName(username: String) -> CheckUsernameResult {
        return .userNameGood
    }
    static func password(password: String) -> CheckPasswordResult {
        return .passwordGood
    }
}
