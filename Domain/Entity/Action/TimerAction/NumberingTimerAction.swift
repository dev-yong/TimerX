//
//  NumberingTimerAction.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct NumberingTimerAction: TimerActionable {
    public let uuid: String
    public let title: String
    public let goal: Int
    public let interval: TimeInterval
    public let countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                title: String = "",
                goal: Int = 5,
                interval: TimeInterval = 1.0,
                countingType: CountingType = .up) {
        self.uuid = uuid
        self.title = title
        self.goal = goal
        self.interval = interval
        self.countingType = countingType
    }
}
