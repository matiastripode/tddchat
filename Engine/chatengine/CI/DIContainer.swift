//
//  DIContainer.swift
//  chatengine
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import Foundation

public protocol DIContainer {
    var service: ChatService {get}
}

public struct DependencyContainer: DIContainer {
    public var service: ChatService
    public init(service: ChatService) {
        self.service = service
    }
}
