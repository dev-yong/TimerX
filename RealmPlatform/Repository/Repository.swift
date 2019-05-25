//
//  Repository.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class Repository<Item: RealmRepresentable>: RxRepositoryProtocol where Item.RMObject.DomainObject == Item {
    private let configuration: Realm.Configuration
    private var realm: Realm {
        do {
            return try Realm(configuration: self.configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        #if DEBUG
        print("Realm URL : ", configuration.fileURL?.absoluteString ?? "")
        #endif
    }
    func save(_ item: Item, update: Bool) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.add(item, update: update)
        }
    }
    func items() -> Observable<[Item]> {
        return Observable.deferred {
            let itemObjects = self.realm.objects(Item.RMObject.self)
            return Observable.array(from: itemObjects)
                .map { $0.map { $0.asDomain() } }
        }
    }
    func item<PrimaryKey>(with primaryKey: PrimaryKey) -> Observable<Item?> {
        return Observable.deferred {
            guard let itemObejct = self.realm.object(ofType: Item.RMObject.self,
                                                     forPrimaryKey: primaryKey) else {
                                                        return .empty()
            }
            return Observable.from(object: itemObejct)
                .map { $0.asDomain() }
        }
    }
    func delete(_ item: Item) -> Observable<Void> {
        return realm.rx.delete(item)
    }
    func delete(contentsOf items: [Item]) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(contentsOf: items)
        }
    }
}
