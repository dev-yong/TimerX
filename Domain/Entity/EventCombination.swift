//
//  EventCombination.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct EventCombination {
    public let uuid: String
    public let title: String
    public var events: [EventProtocol]
    public init(uuid: String = UUID().uuidString,
                title: String,
                events: [EventProtocol]) {
        self.uuid = uuid
        self.title = title
        self.events = events
    }
}
