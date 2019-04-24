//
//  UseCaseProtocol.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

// Repository Pattern
// https://medium.com/@frederikjacques/repository-design-pattern-in-swift-952061485aa
internal protocol RepositoryProtocol {
    associatedtype Item
    func save(_ item: Item, update: Bool) throws
    func items() throws -> [Item]
    func item(with identifier: String) throws -> Item?
    func delete(_ item: Item) throws
}
