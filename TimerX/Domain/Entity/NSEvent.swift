//
//  NSConcreteEvent.swift
//  TimerX
//
//  Created by 이광용 on 14/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

@objcMembers
class NSEvent: NSObject {
    let uuid: String
    init(uuid: String) {
        self.uuid = uuid
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? NSEvent else { return false }
        return self.uuid == object.uuid
    }
}

extension NSEvent {
    func asEventProtocol() -> EventProtocol {
        if let simpleEvent = self as? NSSimpleEvent {
            return simpleEvent.asDomain()
        } else if let coutingEvent = self as? NSCountingEvent {
            return coutingEvent.asDomain()
        } else {
            fatalError("Event convert error")
        }
    }
}
