//
//  UseCaseProtocol.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

// Repository Pattern
public protocol Repository {
    associatedtype Item
    func add(_ item: Item) -> Item
    func items() -> [Item]
    func item(with identifier: String) -> Item?
    func update(_ item: Item) -> Item
    func delete(_ item: Item) -> Item?
}
