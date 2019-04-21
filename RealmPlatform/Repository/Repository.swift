//
//  Repository.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

internal final class Repository<Item: RealmRepresentable>: RepositoryProtocol where Item.RMObject.DomainObject == Item {
    private let configuration: Realm.Configuration
    private var realm: Realm {
        do {
            return try Realm(configuration: self.configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    internal init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    internal func save(_ item: Item, update: Bool) throws {
        try realm.write {
            realm.add(item.asRealm(), update: update)
        }
    }
    internal func items() throws -> [Item] {
        return realm.objects(Item.self)
    }
    internal func item(with identifier: String) throws -> Item? {
        return realm.object(ofType: Item.RMObject.self,
                            forPrimaryKey: identifier)?.asDomain()
    }
    internal func delete(_ item: Item) throws {
        try realm.write {
            realm.delete(item.asRealm())
        }
    }
}

extension Realm {
    internal func objects<Element: RealmRepresentable>(_ type: Element.Type) -> [Element]
        where Element.RMObject.DomainObject == Element {
            return objects(type.RMObject.self).map { $0.asDomain() }
    }
}
