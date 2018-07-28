//
//  Message.swift
//  chatengine
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation

public enum MessageSender {
    case ourself
    case someoneElse
}
public struct Message {
    let message: String
    let senderUsername: String
    let messageSender: MessageSender
    init(message: String, messageSender: MessageSender, username: String) {
        self.message = message.withoutWhitespace()
        self.messageSender = messageSender
        self.senderUsername = username
    }
}
