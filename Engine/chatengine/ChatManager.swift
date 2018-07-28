//
//  ChatManager.swift
//  chatengine
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation

class ChatManager {
    static let shared = ChatManager()
    
    func connect(username: String, password: String, completion: ()->()) {
        completion()
    }
}
