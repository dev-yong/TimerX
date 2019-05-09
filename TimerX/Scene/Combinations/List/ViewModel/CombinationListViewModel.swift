//
//  CombinationListViewModel.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

internal final class CombinationListViewModel: ViewModelProtocol {
    internal struct Input {
        internal let trigger: Driver<Void>
        internal let createCombiationTrigger: Driver<Void>
    }
    internal struct Output {
        internal let createCombination: Driver<Void>
    }
    private var useCase: EventCombinationUseCase
    private var coordinator: CombinationCoordinator
    internal init(useCase: EventCombinationUseCase, coordinator: CombinationCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    internal func transform(_ input: CombinationListViewModel.Input) -> CombinationListViewModel.Output {
        let createCombination = input.createCombiationTrigger.do(onNext: { [weak self] in
            self?.coordinator.coordinate(.create)
        })
        return Output(createCombination: createCombination)
    }
}
