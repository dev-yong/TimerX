//
//  RMAbstractEvent.swift
//  RealmPlatform
//
//  Created by 이광용 on 20/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

@objcMembers
final class RMAnyEvent: Object, RMAnyObjectProtocol {
    dynamic var typeName: String = ""
    dynamic var primaryKey: String = ""
    static var supportedClasses: [RMAbstractEvent.Type] {
        return [RMSimpleEvent.self,
                RMCountingEvent.self]
    }
}

@objcMembers
class RMAbstractEvent: Object, RMAbstractObjectProtocol {
    dynamic var uuid: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

extension RMAbstractEvent: DomainConvertible {
    @objc
    func asDomain() -> AbstractEvent {
        return AbstractEvent(uuid: uuid)
    }
}

extension Domain.AbstractEvent: RealmRepresentable {
    @objc
    func asRealm() -> RMAbstractEvent {
        return RMSimpleEvent.build {
            $0.uuid = uuid
        }
    }
}
