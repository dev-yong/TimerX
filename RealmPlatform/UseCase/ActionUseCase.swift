//
//  ActionUseCase.swift
//  RealmPlatform
//
//  Created by 이광용 on 23/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class ActionUseCase<Repository>: Domain.ActionUseCase
where Repository: RxRepositoryProtocol, Repository.Item == Domain.Action {
    private let repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    func add(_ action: Action, update: Bool) -> Observable<Void> {
        return repository.save(action, update: update)
    }
    func actions() -> Observable<[Action]> {
        return repository.items()
    }
    func action(of uuid: String) -> Observable<Action?> {
        return repository.item(with: uuid)
    }
    func delete(_ action: Action) -> Observable<Void> {
        return repository.delete(action)
    }
}
