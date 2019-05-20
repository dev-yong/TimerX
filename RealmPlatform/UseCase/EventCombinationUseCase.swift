//
//  EventCombinationUseCase.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class EventCombinationUseCase<Repository>: Domain.EventCombinationUseCase
where Repository: RxRepositoryProtocol, Repository.Item == Domain.EventCombination {
    private let repository: Repository
    internal init(repository: Repository) {
        self.repository = repository
    }
    func add(_ eventCombination: EventCombination, update: Bool = true) -> Observable<Void> {
        return repository.save(eventCombination, update: update)
    }
    func eventCombinations() -> Observable<[EventCombination]> {
        return repository.items()
    }
    func eventCombination(of uuid: String) -> Observable<EventCombination?> {
        return repository.item(with: uuid)
    }
    func delete(_ eventCombination: EventCombination) -> Observable<Void> {
        return repository.delete(eventCombination)
    }}
