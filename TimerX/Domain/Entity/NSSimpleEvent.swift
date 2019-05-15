//
//  NSSimpleEvent.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

@objcMembers
class NSSimpleEvent: NSEvent {
    dynamic var seconds: TimeInterval
    dynamic var countingType: CountingType
    init(uuid: String = UUID().uuidString,
         seconds: TimeInterval,
         countingType: CountingType) {
        self.seconds = seconds
        self.countingType = countingType
        super.init(uuid: uuid)
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? NSSimpleEvent else { return false }
       return self.uuid == object.uuid &&
        self.seconds == object.seconds &&
        self.countingType == object.countingType
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
