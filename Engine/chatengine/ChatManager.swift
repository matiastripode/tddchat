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

public protocol ChatService {
    func connect(username: String, password: String, completion: @escaping  ChatManagerConnectCompletion)
}

public final class ChatManager: ChatService {
    private let dependencies: DependencyContainer
    init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
    }
    public func connect(username: String, password: String, completion:  @escaping ChatManagerConnectCompletion) {
        //completion(.failure(error: NSError(domain: "", code: 0, userInfo: [:])))
        dependencies.service.connect(username: username, password: password, completion: completion)
        completion(.success(result: true))
    }
}
