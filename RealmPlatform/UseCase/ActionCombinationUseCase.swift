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

final class ActionCombinationUseCase<Repository>: Domain.ActionCombinationUseCase
where Repository: RxRepositoryProtocol, Repository.Item == Domain.ActionCombination {
    private let repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    func add(_ actionCombination: ActionCombination, update: Bool) -> Observable<Void> {
        return repository.save(actionCombination, update: update)
    }
    func delete(_ actionCombination: ActionCombination) -> Observable<Void> {
        return repository.delete(actionCombination)
    }
    func actionCombinations() -> Observable<[ActionCombination]> {
        return repository.items()
    }
    func actionCombination(of uuid: String) -> Observable<ActionCombination?> {
        return repository.item(with: uuid)
    }
}
