//
//  EventUseCase.swift
//  RealmPlatform
//
//  Created by 이광용 on 23/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class EventUseCase<Repository>: Domain.EventUseCase
where Repository: RxRepositoryProtocol, Repository.Item == Domain.AbstractEvent {
    private let repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    func add<Event>(_ event: Event,
                    update: Bool) -> Observable<Void> where Event: AbstractEvent {
        return repository.save(event, update: update)
    }
    func events<Event>() -> Observable<[Event]> where Event: AbstractEvent {
        return repository.items()
            .map {
                $0.map { $0 as? Event }
                    .compactMap { $0 }
            }
    }
    func event<Event>(of uuid: String) -> Observable<Event?> where Event: AbstractEvent {
        return repository.item(with: uuid)
            .map { $0 as? Event }
    }
    func delete<Event>(_ event: Event) -> Observable<Void> where Event: AbstractEvent {
        return repository.delete(event)
    }
}
