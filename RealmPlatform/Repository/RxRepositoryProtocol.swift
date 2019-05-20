//
//  RxRepositoryProtocol.swift
//  RealmPlatform
//
//  Created by 이광용 on 19/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift

internal protocol RxRepositoryProtocol {
    associatedtype Item
    func save(_ item: Item,
              update: Bool) -> Observable<Void>
    func items() -> Observable<[Item]>
    func item<PrimaryKey>(with primaryKey: PrimaryKey) -> Observable<Item?>
    func delete(_ item: Item) -> Observable<Void>
    func delete(contentsOf items: [Item]) -> Observable<Void>
}
