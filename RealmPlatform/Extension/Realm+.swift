//
//  Realm+.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import RealmSwift

extension Realm {
    func objects<Element: RealmRepresentable>(_ type: Element.Type) -> [Element]
        where Element.RMObject.DomainObject == Element {
            return objects(type.RMObject.self).map { $0.asDomain() }
    }
}

extension Object {
    static func build<O: Object>(_ builder: (O) -> Void ) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension List {
    func asArray() -> [Element] {
        return Array(self)
    }
}

extension List where Element: DomainConvertible {
    func asDomainArray() -> [Element.DomainObject] {
        return asArray().map {
            $0.asDomain()
        }
    }
}

extension Array where Element: RealmRepresentable {
    func asList() -> List<Element.RMObject> {
        let list = List<Element.RMObject>()
        list.append(objectsIn: map { $0.asRealm() })
        return list
    }
}
