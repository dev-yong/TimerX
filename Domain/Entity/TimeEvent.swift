//
//  TimeEvent.swift
//  Domain
//
//  Created by 이광용 on 17/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol EventProtocol {
    var title: String { get }
    var countingType: CountingType { get }
}

public struct TimeEvent: EventProtocol {
    public let title: String
    public let seconds: TimeInterval
    public let countingType: CountingType
    public var alarms: [TimeInterval]
}
