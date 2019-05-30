//
//  RMActionGroup.swift
//  RealmPlatform
//
//  Created by 이광용 on 27/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

class RMLoopAction: RMAbstractActionGroup {
}

extension RMLoopAction {
    override func asDomain() -> Domain.LoopAction {
        return LoopAction(uuid: uuid,
                          title: title,
                          actions: actions.asDomainArray())
    }
}
