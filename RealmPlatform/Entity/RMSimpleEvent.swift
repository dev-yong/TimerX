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
internal final class RMSimpleEvent: Object, Domain.EventProtocol {
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

extension RMSimpleEvent: DomainConvertible {
    internal func asDomain() -> Domain.SimpleEvent {
        return Domain.SimpleEvent(uuid: uuid,
                                seconds: seconds,
                                countingType: countingType)
    }
}
extension Domain.SimpleEvent: RealmRepresentable {
    internal func asRealm() -> RMSimpleEvent {
        return RMSimpleEvent.build {
            $0.uuid = uuid
            $0.seconds = seconds
            $0.countingType = countingType
        }
    }
}
