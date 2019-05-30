//
//  RMAbstractActionGroup.swift
//  RealmPlatform
//
//  Created by 이광용 on 27/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

class RMAnyActionGroup: RMAbstractAction {
}

class RMAbstractActionGroup: RMAbstractAction {
    var actions = List<RMAbstractAction>()
}

extension RMAbstractActionGroup {
    override func asDomain() -> ActionGroup {
        return ActionGroup(uuid: uuid,
                           title: title,
                           actions: actions.asDomainArray())
    }
}
extension ActionGroup {
    override func asRealm() -> RMAbstractActionGroup {
        return RMAbstractActionGroup.build {
            $0.uuid = uuid
            $0.title = title
            $0.actions = actions.asList()
        }
    }
}
