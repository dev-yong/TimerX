//
//  TimeEvent.swift
//  Domain
//
//  Created by 이광용 on 17/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct SimpleEvent: EventProtocol {
    public let uuid: String
    public let seconds: TimeInterval
    public var countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                seconds: TimeInterval,
                countingType: CountingType) {
        self.uuid = uuid
        self.seconds = seconds
        self.countingType = countingType
    }
}

extension SimpleEvent: Equatable {
    public static func == (lhs: SimpleEvent,
                           rhs: SimpleEvent) -> Bool {
        return lhs.uuid == rhs.uuid &&
            lhs.seconds == rhs.seconds &&
            lhs.countingType == rhs.countingType
    }
}
