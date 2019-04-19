//
//  Repository.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

internal final class Repository<Item: RealmRepresentable>: RepositoryProtocol {
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
        try realm.write {
            realm.objects(Item.RealmObject.self)
        }
    }
    internal func item(with identifier: String) throws -> Item? {
        try realm.write {
            realm.object(ofType: Item.RealmObject.self,
                         forPrimaryKey: identifier)
        }
    }
    internal func delete(_ item: Item) throws {
        try realm.write {
            realm.delete(item.asRealm())
        }
    }
}
