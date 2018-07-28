//
//  ChatServiceSockets.swift
//  chatengine
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation

public protocol ChatRoomDelegate: class {
    func receivedMessage(message: Message)
}

public class ChatServiceSockets: NSObject, ChatService {
    weak var delegate: ChatRoomDelegate?
    var inputStream: InputStream!
    var outputStream: OutputStream!
    var username = ""
    let maxReadLength = 1024
    // MARK: ChatService Protocol
    public func connect(username: String, password: String, completion: @escaping ChatManagerConnectCompletion) {
        setupNetworkCommunication()
        joinChat(username: username)
        completion(.success(result: true))
    }
    // MARK: Sockets
    //1) Set up the input and output streams for message sending
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           "localhost" as CFString,
                                           80,
                                           &readStream,
                                           &writeStream)
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        inputStream.delegate = self
        outputStream.delegate = self
        inputStream.schedule(in: .main, forMode: .commonModes)
        outputStream.schedule(in: .main, forMode: .commonModes)
        inputStream.open()
        outputStream.open()
    }
    func joinChat(username: String) {
        let data = "iam:\(username)".data(using: .ascii)!
        self.username = username
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    func sendMessage(message: String) {
        let data = "msg:\(message)".data(using: .ascii)!
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    func stopChatSession() {
        inputStream.close()
        outputStream.close()
    }
}

// MARK: StreamDelegate / Sockets
extension ChatServiceSockets: StreamDelegate {
    public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case Stream.Event.hasBytesAvailable:
            print("new message received")
            if let inputStream = aStream as? InputStream {
                readAvailableBytes(stream: inputStream)
            }
        case Stream.Event.endEncountered:
            stopChatSession()
        case Stream.Event.errorOccurred:
            print("error occurred")
        case Stream.Event.hasSpaceAvailable:
            print("has space available")
        default:
            print("some other event...")
        }
    }
    private func readAvailableBytes(stream: InputStream) {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            if numberOfBytesRead < 0 {
                if inputStream.streamError != nil {
                    break
                }
            }
            if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                delegate?.receivedMessage(message: message)
            }
        }
    }
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>,
                                        length: Int) -> Message? {
        guard let stringArray = String(bytesNoCopy: buffer,
                                       length: length,
                                       encoding: .ascii,
                                       freeWhenDone: true)?.components(separatedBy: ":"),
            let name = stringArray.first,
            let message = stringArray.last else {
                return nil
        }
        let messageSender: MessageSender = (name == self.username) ? .ourself : .someoneElse
        return Message(message: message, messageSender: messageSender, username: name)
    }
}
