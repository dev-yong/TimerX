//
//  TimeEvent.swift
//  Domain
//
//  Created by 이광용 on 17/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct TimeEvent: EventProtocol {
    public let title: String
    public let seconds: TimeInterval
    public let countingType: CountingType
    public var alarms: [TimeInterval]
}

extension TimeEvent: Equatable {
    public static func == (lhs: TimeEvent,
                           rhs: TimeEvent) -> Bool {
        return lhs.title == rhs.title &&
        lhs.seconds == rhs.seconds &&
        lhs.countingType == rhs.countingType &&
        lhs.alarms == rhs.alarms
    }
}
