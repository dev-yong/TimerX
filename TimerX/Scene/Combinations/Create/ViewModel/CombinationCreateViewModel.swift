//
//  CombinationCreateViewModel.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

internal final class CombinationCreateViewModel: ViewModelProtocol {
    internal struct Input {
//        internal let title: Driver<String>
        internal let saveTrigger: Driver<Void>
    }
    internal struct Output {
//        internal let isSaveEnable: Driver<Bool>
        internal let dismiss: Driver<Void>
    }
    private var useCase: EventCombinationUseCase
    private var coordinator: CombinationCoordinator
    internal init(useCase: EventCombinationUseCase, coordinator: CombinationCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func transform(_ input: CombinationCreateViewModel.Input) -> CombinationCreateViewModel.Output {
        let dismiss = input.saveTrigger
            .do(onNext: { self.coordinator.coordinate(CombinationRoute.combinations) })
        return Output(dismiss: dismiss)
    }
}
