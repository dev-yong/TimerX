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
final class RMSimpleEvent: RMAbstractEvent {
    dynamic var seconds: Double = 0.0
    private dynamic var _countingType = CountingType.up.rawValue
    var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
    var alarms = List<Double>()
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

extension RMSimpleEvent: DomainConvertible {
    func asDomain() -> Domain.SimpleEvent {
        return Domain.SimpleEvent(uuid: uuid,
                                seconds: seconds,
                                countingType: countingType)
    }
}
extension Domain.SimpleEvent: RealmRepresentable {
    func asRealm() -> RMSimpleEvent {
        return RMSimpleEvent.build {
            $0.uuid = uuid
            $0.seconds = seconds
            $0.countingType = countingType
        }
    }
}
