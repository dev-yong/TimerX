//
//  Repository.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

public final class Repository<Item: RealmRepresentable>: RepositoryProtocol where Item.RMObject.DomainObject == Item {
    private let configuration: Realm.Configuration
    private var realm: Realm {
        do {
            return try Realm(configuration: self.configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    public init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    public func save(_ item: Item, update: Bool) throws {
        try realm.write {
            realm.add(item.asRealm(), update: update)
        }
    }
    public func items() throws -> [Item] {
        return realm.objects(Item.self)
    }
    public func item(with identifier: String) throws -> Item? {
        return realm.object(ofType: Item.RMObject.self,
                            forPrimaryKey: identifier)?.asDomain()
    }
    public func delete(_ item: Item) throws {
        try realm.write {
            realm.delete(item.asRealm())
        }
    }
}

internal extension Realm {
    func objects<Element: RealmRepresentable>(_ type: Element.Type) -> [Element]
        where Element.RMObject.DomainObject == Element {
            return objects(type.RMObject.self).map { $0.asDomain() }
    }
}
