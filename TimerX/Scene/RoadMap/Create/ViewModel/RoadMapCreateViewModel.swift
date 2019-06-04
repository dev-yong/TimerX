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

final class RoadMapCreateViewModel: ViewModelProtocol {
    struct Input {
//        let title: Driver<String>
        let addSimpleTimerTrigger: Driver<Void>
        let addNumberingTimerTrigger: Driver<Void>
        let deleteActionTrigger: Driver<RoadMapRow>
        let saveRoadMapTrigger: Driver<Void>
    }
    struct Output {
        let sections: Driver<[RoadMapSection]>
        let addSimpleTimer: Driver<Void>
        let addNumberingTimer: Driver<Void>
        let deleteAction: Driver<Void>
        let saveRoadMap: Driver<Void>
//        let dismiss: Driver<Void>
    }
    private var disposeBag = DisposeBag()
    private let roadMapUseCase: RoadMapUseCase
    private let actionUseCase: ActionUseCase
    private let coordinator: RoadMapCoordinator
    init(roadMapUseCase: RoadMapUseCase,
         actionUseCase: ActionUseCase,
         coordinator: RoadMapCoordinator) {
        self.roadMapUseCase = roadMapUseCase
        self.actionUseCase = actionUseCase
        self.coordinator = coordinator
    }
    func transform(_ input: RoadMapCreateViewModel.Input) -> RoadMapCreateViewModel.Output {
        let roadMap = BehaviorRelay(value: RoadMap(title: "", actions: []))
        let addSimpleEvent = input.addSimpleTimerTrigger.map { _ in
            return SimpleTimerAction()
        }.do(onNext: {
//            actions.append($0)
        })
        let addNumberingTimer = input.addNumberingTimerTrigger.map { _ in
            return NumberingTimerAction()
        }.do(onNext: {
//            actions.append($0)
        })
        let sections = roadMap.asDriver().map { _ in
            return [RoadMapSection]()
        }
//            $0.map { event -> RoadMapRow? in
//                if let simpleEvent = event as? NSSimpleEvent {
//                    return .simple(viewModel: SimpleEventCellViewModel(event: simpleEvent))
//                } else if let countingEvent = event as? NSCountingEvent {
//                    return .counting(viewModel: CountingEventCellViewModel(event: countingEvent))
//                }
//                return nil
//            }.compactMap { $0 }
//        }.map {
//            [RoadMapSection(items: $0)]
//        }
        let deleteEvent = input.deleteActionTrigger
            .map { $0.action }
            .unwrap()
            .do(onNext: { action in
//                var newValue = actions.value
//                newValue.removeAll { $0.uuid == action.uuid }
//                actions.accept(newValue)
            }).mapToVoid()
        let saveRoadMap = input.saveRoadMapTrigger.asDriver()
            .withLatestFrom(roadMap.asDriver())
            .mapToVoid()
//            .map {
//                RoadMap(title: "TITLE", actions: $0)
//            }
        return Output(sections: sections,
                      addSimpleTimer: addSimpleEvent.asDriver(),
                      addNumberingTimer: addNumberingTimer.asDriver(),
                      deleteAction: deleteEvent,
                      saveRoadMap: saveRoadMap)
    }
}
