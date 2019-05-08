//
//  CountingEvent.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct CountingEvent: EventProtocol {
    public let uuid: String
    public let goal: Int
    public let interval: TimeInterval
    public let countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                goal: Int,
                interval: TimeInterval,
                countingType: CountingType) {
        self.uuid = uuid
        self.goal = goal
        self.interval = interval
        self.countingType = countingType
    }
}

extension CountingEvent: Equatable {
    public static func == (lhs: CountingEvent,
                           rhs: CountingEvent) -> Bool {
        return lhs.uuid == rhs.uuid &&
            lhs.interval == rhs.interval &&
            lhs.countingType == rhs.countingType &&
            lhs.goal == rhs.goal
    }
}
