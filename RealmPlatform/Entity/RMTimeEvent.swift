//
//  RMTimeEvent.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

@objcMembers
internal final class RMTimeEvent: Object, Domain.EventProtocol {
    internal dynamic var index: Int = 0
    internal dynamic var uuid: String = ""
    internal dynamic var title: String = ""
    internal dynamic var seconds: TimeInterval = 0.0
    internal dynamic var _countingType = CountingType.up.rawValue
    internal var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
    internal var alarms = List<TimeInterval>()
}

extension RMTimeEvent: DomainConvertible {
    internal func asDomain() -> Domain.TimeEvent {
        return Domain.TimeEvent(index: index,
                                uuid: uuid,
                                title: title,
                                seconds: seconds,
                                countingType: countingType,
                                alarms: alarms.asArray())
    }
}
extension Domain.TimeEvent: RealmRepresentable {
    internal func asRealm() -> RMTimeEvent {
        return RMTimeEvent.build {
            $0.index = index
            $0.uuid = uuid
            $0.title = title
            $0.seconds = seconds
            $0.countingType = countingType
            $0.alarms = alarms.asList()
        }
    }
}
