//
//  NSCountingEvent.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

@objcMembers
class NSCountingEvent: NSEvent {
    dynamic var goal: Int
    dynamic var interval: TimeInterval
    dynamic var countingType: CountingType
    init(uuid: String = UUID().uuidString,
         goal: Int,
         interval: TimeInterval,
         countingType: CountingType) {
        self.goal = goal
        self.interval = interval
        self.countingType = countingType
        super.init(uuid: uuid)
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? NSCountingEvent else { return false }
        return self.uuid == object.uuid &&
            self.goal == object.goal &&
            self.interval == object.interval &&
            self.countingType == object.countingType
    }
}
extension NSCountingEvent: DomainConvertible {
    func asDomain() -> CountingEvent {
        return CountingEvent(uuid: uuid,
                             goal: goal,
                             interval: interval,
                             countingType: countingType)
    }
}
extension CountingEvent: NSObjectRepresentable {
    func asNSObject() -> NSCountingEvent {
        return NSCountingEvent(uuid: uuid,
                               goal: goal,
                               interval: interval,
                               countingType: countingType)
    }
}
