//
//  RMCountingEvent.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

@objcMembers
final class RMCountingEvent: RMAbstractEvent {
    dynamic var goal: Int = 0
    dynamic var interval: Double = 0.0
    private dynamic var _countingType = CountingType.up.rawValue
    var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
}

extension Domain.CountingEvent {
    override func asRealm() -> RMCountingEvent {
        return RMCountingEvent.build {
            $0.uuid = uuid
            $0.goal = goal
            $0.interval = interval
            $0.countingType = countingType
        }
    }
}

extension RMCountingEvent {
    override func asDomain() -> Domain.CountingEvent {
        return Domain.CountingEvent(uuid: uuid,
                                    goal: goal,
                                    interval: interval,
                                    countingType: countingType)
    }
}
