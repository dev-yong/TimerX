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
class RMAnyAction: Object, RMAnyObjectProtocol {
    dynamic var typeName: String = ""
    dynamic var primaryKey: String = ""
    static var supportedClasses: [RMAbstractAction.Type] {
        return []
    }
}

@objcMembers
class RMAbstractAction: Object, RMAbstractObjectProtocol {
    dynamic var uuid: String = ""
    dynamic var title: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

extension RMAbstractAction: DomainConvertible {
    @objc
    func asDomain() -> Action {
        return Action(uuid: uuid, title: title)
    }
}

extension Action: RealmRepresentable {
    @objc
    func asRealm() -> RMAbstractAction {
        return RMAbstractAction.build {
            $0.uuid = uuid
            $0.title = title
        }
    }
}
