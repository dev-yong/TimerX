//
//  NumberingTimerAction.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class NumberingTimerAction: TimerAction {
    public override class var identifier: String {
        return [super.identifier, "numbering"].joined(separator: ".")
    }
    public let goal: Int
    public let interval: TimeInterval
    public let countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                title: String,
                goal: Int,
                interval: TimeInterval,
                countingType: CountingType) {
        self.goal = goal
        self.interval = interval
        self.countingType = countingType
        super.init(uuid: uuid,
                   title: title)
    }
    public override func isEqual(_ object: Any?) -> Bool {
        guard let numberingTimerAction = object as? NumberingTimerAction else { return false }
        return numberingTimerAction.uuid == uuid &&
            numberingTimerAction.title == title &&
            numberingTimerAction.goal == goal &&
            numberingTimerAction.interval == interval &&
            numberingTimerAction.countingType == countingType
    }
}
