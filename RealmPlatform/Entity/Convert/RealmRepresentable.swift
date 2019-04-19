//
//  RealmRepresentable.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

internal protocol RealmRepresentable {
    associatedtype RealmObject: DomainConvertible

    var uuid: String { get }
    func asRealm() -> RealmObject
}
