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
    internal func save(_ item: Item,
                       update: Bool,
                       completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(item.asRealm(), update: update)
            }
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }
    internal func items(completion: @escaping (Result<[Item], Error>) -> Void) {
        completion(.success(realm.objects(Item.self)))
    }
    internal func item<PrimaryKey>(with primaryKey: PrimaryKey,
                                   completion: @escaping (Result<Item?, Error>) -> Void) {
        let domain = realm.object(ofType: Item.RMObject.self,
                                  forPrimaryKey: primaryKey)?.asDomain()
        completion(.success(domain))
    }
    internal func delete(_ item: Item,
                         completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.delete(item.asRealm())
            }
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }
}
