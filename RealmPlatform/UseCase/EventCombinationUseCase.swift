//
//  EventCombinationUseCase.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

final class EventCombinationUseCase<Repository>: Domain.EventCombinationUseCase where Repository: RepositoryProtocol, Repository.Item == Domain.EventCombination {
    private let repository: Repository
    internal init(repository: Repository) {
        self.repository = repository
    }
    internal func add(_ eventCombination: EventCombination,
                      completion: @escaping (Result<Void, Error>) -> Void) {
        repository.save(eventCombination,
                        update: true) {
                            completion($0)
        }
    }
    internal func eventCombinations(completion: @escaping (Result<[EventCombination], Error>) -> Void) {
        repository.items {
            completion($0)
        }
    }
    internal func eventCombination(of uuid: String, completion: @escaping (Result<EventCombination?, Error>) -> Void) {
        repository.item(with: uuid) {
            completion($0)
        }
    }
    internal func update(_ eventCombination: EventCombination, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.save(eventCombination,
                        update: true) {
                            completion($0)
        }
    }
    internal func delete(_ eventCombination: EventCombination, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.delete(eventCombination) {
            completion($0)
        }
    }
}
