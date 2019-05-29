//
//  SimpleTimerAction.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class SimpleTimerAction: TimerAction {
    public override class var identifier: String {
        return [super.identifier, "simpler"].joined(separator: ".")
    }
    public let seconds: TimeInterval
    public let countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                title: String,
                seconds: TimeInterval,
                countingType: CountingType) {
        self.seconds = seconds
        self.countingType = countingType
        super.init(uuid: uuid,
                   title: title)
    }
    public override func isEqual(_ object: Any?) -> Bool {
        guard let simpleTimerAction = object as? SimpleTimerAction else { return false }
        return simpleTimerAction.uuid == uuid &&
            simpleTimerAction.title == title &&
            simpleTimerAction.seconds == seconds &&
            simpleTimerAction.countingType == countingType
    }
}
