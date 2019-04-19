//
//  CountingEvent.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct CountingEvent: EventProtocol {
    public let title: String
    public let interval: TimeInterval
    public let countingType: CountingType
    public let goal: Int
}

extension CountingEvent: Equatable {
    public static func == (lhs: CountingEvent,
                           rhs: CountingEvent) -> Bool {
        return lhs.title == rhs.title &&
            lhs.interval == rhs.interval &&
            lhs.countingType == rhs.countingType &&
            lhs.goal == rhs.goal
    }
}
