//
//  NSSimpleEvent.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

typealias NSEventProtocol = NSObject

@objcMembers
class NSSimpleEvent: NSEventProtocol {
    let uuid: String
    dynamic var seconds: TimeInterval
    dynamic var countingType: CountingType
    init(uuid: String = UUID().uuidString,
         seconds: TimeInterval,
         countingType: CountingType) {
        self.uuid = uuid
        self.seconds = seconds
        self.countingType = countingType
    }
}
extension NSSimpleEvent: DomainConvertible {
    func asDomain() -> SimpleEvent {
        return SimpleEvent(uuid: uuid,
                         seconds: seconds,
                         countingType: countingType)
    }
}
extension SimpleEvent: NSObjectRepresentable {
    func asNSObject() -> NSSimpleEvent {
        return NSSimpleEvent(uuid: uuid,
                           seconds: seconds,
                           countingType: countingType)
    }
}
