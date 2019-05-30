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
final class RMSimpleTimerAction: RMAbstractTimerAction {
    dynamic var seconds: Double = 0.0
    private dynamic var _countingType = CountingType.up.rawValue
    var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
    var alarms = List<Double>()
}

extension RMSimpleTimerAction {
    override func asDomain() -> Domain.SimpleTimerAction {
        return Domain.SimpleTimerAction(uuid: uuid,
                                        title: title,
                                        seconds: seconds,
                                        countingType: countingType)
    }
}
extension Domain.SimpleTimerAction {
    override func asRealm() -> RMSimpleTimerAction {
        return RMSimpleTimerAction.build {
            $0.uuid = uuid
            $0.title = title
            $0.seconds = seconds
            $0.countingType = countingType
        }
    }
}
