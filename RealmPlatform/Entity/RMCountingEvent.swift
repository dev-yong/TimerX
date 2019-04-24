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
internal final class RMCountingEvent: Object, Domain.EventProtocol {
    internal dynamic var index: Int = 0
    internal dynamic var uuid: String = ""
    internal dynamic var title: String = ""
    internal dynamic var interval: TimeInterval = 0.0
    internal dynamic var _countingType = CountingType.up.rawValue
    internal var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
    internal dynamic var goal: Int = 0
}

extension Domain.CountingEvent: RealmRepresentable {
    internal func asRealm() -> RMCountingEvent {
        return RMCountingEvent.build {
            $0.index = index
            $0.uuid = uuid
            $0.title = title
            $0.interval = interval
            $0.countingType = countingType
            $0.goal = goal
        }
    }
}

extension RMCountingEvent: DomainConvertible {
    internal func asDomain() -> Domain.CountingEvent {
        return Domain.CountingEvent(index: index,
                                    uuid: uuid,
                                    title: title,
                                    interval: interval,
                                    countingType: countingType,
                                    goal: goal)
    }
}
