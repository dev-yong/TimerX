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

final class CombinationCreateViewModel: ViewModelProtocol {
    struct Input {
//        let title: Driver<String>
        let addSimpleEventTrigger: Driver<Void>
        let addCountingEventTrigger: Driver<Void>
        let saveCombinationTrigger: Driver<Void>
    }
    struct Output {
        let sections: Driver<[CombinationSection]>
        let addSimpleEvent: Driver<CombinationRow>
        let addCountingEvent: Driver<CombinationRow>
//        let dismiss: Driver<Void>
    }
    private var disposeBag = DisposeBag()
    private var useCase: EventCombinationUseCase
    private var coordinator: CombinationCoordinator
    private let combinationRow = BehaviorRelay(value: [CombinationRow]())
    init(useCase: EventCombinationUseCase, coordinator: CombinationCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func transform(_ input: CombinationCreateViewModel.Input) -> CombinationCreateViewModel.Output {
        let sections = BehaviorRelay(value: [CombinationSection]())
        let addSimpleEvent = input.addSimpleEventTrigger.map { _ in
            return NSSimpleEvent(seconds: 60, countingType: .up)
        }.map {
            return CombinationRow.simple(uuid: $0.uuid,
                                         viewModel: SimpleEventCellViewModel(simpleEvent: $0))
        }
        .do(onNext: { [weak self] in  self?.combinationRow.append($0) })
        let addCountingEvent = input.addCountingEventTrigger.map { _ in
            return NSCountingEvent(goal: 10, interval: 1, countingType: .up)
        }.map {
            return CombinationRow.counting(uuid: $0.uuid,
                                           viewModel: CountingEventCellViewModel(countingEvent: $0))
        }
        .do(onNext: { [weak self] in  self?.combinationRow.append($0) })
        combinationRow.asDriver()
            .map { [CombinationSection(items: $0)] }
            .drive(sections)
            .disposed(by: disposeBag)
        return Output(sections: sections.asDriver(),
                      addSimpleEvent: addSimpleEvent.asDriver(),
                      addCountingEvent: addCountingEvent.asDriver())
    }
}
