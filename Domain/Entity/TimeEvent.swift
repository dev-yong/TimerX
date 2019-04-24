//
//  TimeEvent.swift
//  Domain
//
//  Created by 이광용 on 17/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct TimeEvent: EventProtocol {
    public let index: Int
    public let uuid: String
    public let title: String
    public let seconds: TimeInterval
    public let countingType: CountingType
    public var alarms: [TimeInterval]
    public init(index: Int,
                uuid: String = UUID().uuidString,
                title: String,
                seconds: TimeInterval,
                countingType: CountingType,
                alarms: [TimeInterval]) {
        self.index = index
        self.uuid = uuid
        self.title = title
        self.seconds = seconds
        self.countingType = countingType
        self.alarms = alarms
    }
}

extension TimeEvent: Equatable {
    public static func == (lhs: TimeEvent,
                           rhs: TimeEvent) -> Bool {
        return lhs.index == rhs.index &&
            lhs.uuid == rhs.uuid &&
            lhs.title == rhs.title &&
            lhs.seconds == rhs.seconds &&
            lhs.countingType == rhs.countingType &&
            lhs.alarms == rhs.alarms
    }
}
