//
//  RealmRepresentable.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmRepresentable {
    associatedtype RMObject: DomainConvertible & Object
    var uuid: String { get }
    func asRealm() -> RMObject
}
