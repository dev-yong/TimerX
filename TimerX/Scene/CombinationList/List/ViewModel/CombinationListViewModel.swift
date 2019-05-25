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

final class CombinationListViewModel: ViewModelProtocol {
    struct Input {
        let trigger: Driver<Void>
        let createCombiationTrigger: Driver<Void>
    }
    struct Output {
        let createCombination: Driver<Void>
        let combinationListSections: Driver<[CombinationListSection]>
    }
    private let combinationUseCase: EventCombinationUseCase
    private let coordinator: CombinationCoordinator
    init(combinationUseCase: EventCombinationUseCase,
         coordinator: CombinationCoordinator) {
        self.combinationUseCase = combinationUseCase
        self.coordinator = coordinator
    }
    func transform(_ input: CombinationListViewModel.Input) -> CombinationListViewModel.Output {
        let createCombination = input.createCombiationTrigger.do(onNext: { [weak self] in
            self?.coordinator.coordinate(.create)
        })
        let combinationListSections = combinationUseCase.eventCombinations()
            .asDriver(onErrorJustReturn: [])
            .map {
                $0.map { CombinationCellViewModel(combination: $0) }
                .map { CombinationListRow(viewModel: $0) }
            }
            .map { [CombinationListSection(items: $0)] }
        return Output(createCombination: createCombination,
                      combinationListSections: combinationListSections)
    }
}
