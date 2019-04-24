//
//  CountingEvent.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct CountingEvent: EventProtocol {
    public let index: Int
    public let uuid: String
    public let title: String
    public let interval: TimeInterval
    public let countingType: CountingType
    public let goal: Int
    public init(index: Int,
                uuid: String = UUID().uuidString,
                title: String,
                interval: TimeInterval,
                countingType: CountingType,
                goal: Int) {
        self.index = index
        self.uuid = uuid
        self.title = title
        self.interval = interval
        self.countingType = countingType
        self.goal = goal
    }
}

extension CountingEvent: Equatable {
    public static func == (lhs: CountingEvent,
                           rhs: CountingEvent) -> Bool {
        return lhs.index == rhs.index &&
            lhs.uuid == rhs.uuid &&
            lhs.title == rhs.title &&
            lhs.interval == rhs.interval &&
            lhs.countingType == rhs.countingType &&
            lhs.goal == rhs.goal
    }
}
