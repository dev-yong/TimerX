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
        let deleteEventTrigger: Driver<CombinationRow>
        let saveCombinationTrigger: Driver<Void>
    }
    struct Output {
        let sections: Driver<[CombinationSection]>
        let addSimpleEvent: Driver<NSSimpleEvent>
        let addCountingEvent: Driver<NSCountingEvent>
        let deleteEvent: Driver<Void>
        let saveCombination: Driver<Void>
//        let dismiss: Driver<Void>
    }
    private var disposeBag = DisposeBag()
    private let combinationUseCase: EventCombinationUseCase
    private let eventUseCase: EventUseCase
    private let coordinator: CombinationCoordinator
    init(combinationUseCase: EventCombinationUseCase,
         eventUseCase: EventUseCase,
         coordinator: CombinationCoordinator) {
        self.combinationUseCase = combinationUseCase
        self.eventUseCase = eventUseCase
        self.coordinator = coordinator
    }
    func transform(_ input: CombinationCreateViewModel.Input) -> CombinationCreateViewModel.Output {
        let events = BehaviorRelay(value: [NSEvent]())
        let addSimpleEvent = input.addSimpleEventTrigger.map { _ in
            return NSSimpleEvent(seconds: 60, countingType: .up)
        }.do(onNext: { events.append($0) })
        let addCountingEvent = input.addCountingEventTrigger.map { _ in
            return NSCountingEvent(goal: 10, interval: 1, countingType: .up)
        }.do(onNext: { events.append($0) })
        let sections = events.asDriver().map {
            $0.map { event -> CombinationRow? in
                if let simpleEvent = event as? NSSimpleEvent {
                    return .simple(viewModel: SimpleEventCellViewModel(event: simpleEvent))
                } else if let countingEvent = event as? NSCountingEvent {
                    return .counting(viewModel: CountingEventCellViewModel(event: countingEvent))
                }
                return nil
            }.compactMap { $0 }
        }.map {
            [CombinationSection(items: $0)]
        }
        let deleteEvent = input.deleteEventTrigger.do(onNext: {
            events.remove($0.event)
        }).mapToVoid()
        let saveCombination = input.saveCombinationTrigger.asObservable()
            .withLatestFrom(events.asDriver())
            .map {
                $0.map { $0.asAbstractEvent() }
                    .compactMap { $0 }
            }
            .flatMapLatest { events -> Observable<[AbstractEvent]> in
                Observable.combineLatest(events.map { self.eventUseCase.add($0, update: true) })
                    .map { _ in events }
            }
            .map {
                EventCombination(title: "Title Test", events: $0)
            }
            .flatMapLatest { combiation -> Observable<Void> in
                return self.combinationUseCase.add(combiation, update: true)
            }.asDriverOnErrorJustNever()
        return Output(sections: sections,
                      addSimpleEvent: addSimpleEvent.asDriver(),
                      addCountingEvent: addCountingEvent.asDriver(),
                      deleteEvent: deleteEvent,
                      saveCombination: saveCombination)
    }
}
