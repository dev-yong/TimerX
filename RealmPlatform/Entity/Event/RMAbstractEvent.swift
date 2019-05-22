//
//  RMAbstractEvent.swift
//  RealmPlatform
//
//  Created by 이광용 on 20/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class RMAbstractEvent: Object, RMAbstractObjectProtocol {
    dynamic var uuid: String = ""
}

@objcMembers
final class RMAnyEvent: Object, RMAnyObjectProtocol {
    dynamic var typeName: String = ""
    dynamic var primaryKey: String = ""
    static var supportedClasses: [RMAbstractEvent.Type] = [RMSimpleEvent.self,
                                                           RMCountingEvent.self]
}
