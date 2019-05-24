//
//  CountingEvent.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class CountingEvent: AbstractEvent {
    public let goal: Int
    public let interval: TimeInterval
    public var countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                goal: Int,
                interval: TimeInterval,
                countingType: CountingType) {
        self.goal = goal
        self.interval = interval
        self.countingType = countingType
        super.init(uuid: uuid)
    }
}

extension CountingEvent {
    public static func == (lhs: CountingEvent,
                           rhs: CountingEvent) -> Bool {
        return lhs.uuid == rhs.uuid &&
            lhs.interval == rhs.interval &&
            lhs.countingType == rhs.countingType &&
            lhs.goal == rhs.goal
    }
}
