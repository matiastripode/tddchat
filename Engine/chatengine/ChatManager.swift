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

public final class ChatManager {
    public static let shared = ChatManager()
    public func connect(username: String, password: String, completion: ChatManagerConnectCompletion) {
        //completion(.failure(error: NSError(domain: "", code: 0, userInfo: [:])))
        completion(.success(result: true))
    }
}
