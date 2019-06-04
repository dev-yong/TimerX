//
//  CountingEventCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 07/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class NumberingTimerCellViewModel: ActionCellViewMdoelProtocol {
    struct Input: ActionCellViewModelInputProtocol {
        let rowSelectionTrigger: Driver<NumberingTimerRow>
        let countSegmentSelectionTrigger: Driver<Int>
    }
    struct Output: ActionCellViewModelOutputProtocool {
        let title: Driver<String>
        let sections: Driver<[NumberingTimerSection]>
        let countSegmentSelection: Driver<Void>
    }
    let action: NumberingTimerAction
    private lazy var sections = BehaviorRelay(value: self.makeEventCellSections())
    init(action: NumberingTimerAction) {
        self.action = action
    }
    func transform(_ input: Input) -> Output {
        let timeRowSelecionTrigger = input.rowSelectionTrigger.asDriver()
            .filter {
                switch $0 {
                case .time: return true
                default: return false
                }
            }
        let countSegmentSelection = input.countSegmentSelectionTrigger
            .map { CountingType(rawValue: $0) ?? .up }
            .do(onNext: { [weak self] in
//                self?.action.countingType = $0
            }).mapToVoid()
        return Output(title: Driver.just("Counting"),
                      sections: sections.asDriver(),
                      countSegmentSelection: countSegmentSelection)
    }
    private func makeEventCellSections() -> [NumberingTimerSection] {
        return []
//        // Goal
//        let goal = action.rx.observe(Int.self, "goal")
//            .asDriverOnErrorJustComplete()
//            .unwrap()
//            .distinctUntilChanged()
//        let eventGoalCellViewModel = EventGoalCellViewModel(goal: goal)
//        let goalRow: NumberingTimerRow = .goal(viewModel: eventGoalCellViewModel)
//        // Time or Interval
//        let interval = event.rx.observe(TimeInterval.self, "interval")
//            .asDriverOnErrorJustComplete()
//            .unwrap()
//        let description = interval
//            .map { Time(timeInterval: $0) }
//            .map { String(format: "%0.2d:%0.2d:%0.2d", $0.hours, $0.minutes, $0.seconds) }
//        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Interval",
//                                                            description: description)
//        let timeRow: NumberingTimerRow = .time(viewModel: eventTimeCellViewModel)
//        // Count Up/Down Segment
//        let countingType = event.rx.observe(CountingType.self, "countingType")
//            .asDriverOnErrorJustComplete()
//            .unwrap()
//        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountType: countingType)
//        let countTypeRow: NumberingTimerRow = .countType(viewModel: eventCountTypeCellViewModel)
//        return [NumberingTimerSection(items: [goalRow, timeRow, countTypeRow])]
    }
}
