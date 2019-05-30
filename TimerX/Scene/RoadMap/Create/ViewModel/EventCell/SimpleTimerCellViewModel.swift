//
//  SimpleEventCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class SimpleTimerCellViewModel: ActionCellViewMdoelProtocol {
    struct Input: ActionCellViewModelInputProtocol {
        let rowSelectionTrigger: Driver<SimpleTimerRow>
        let countSegmentSelectionTrigger: Driver<Int>
    }
    struct Output: ActionCellViewModelOutputProtocool {
        let title: Driver<String>
        let sections: Driver<[SimpleTimerSection]>
        let countSegmentSelection: Driver<Void>
    }
    let action: SimpleTimerAction
    private let showTimePicker = BehaviorRelay(value: false)
    init(action: SimpleTimerAction) {
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
                self?.event.countingType = $0
            }).mapToVoid()
        return Output(title: Driver.just("Simple"),
                      sections: Driver.just(makeEventCellSections()),
                      countSegmentSelection: countSegmentSelection)
    }
    private func makeEventCellSections() -> [SimpleTimerSection] {
        // Time or Interval
        let seconds = event.rx.observe(TimeInterval.self, "seconds")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let description = seconds
            .map { Time(timeInterval: $0) }
            .map { $0.description }
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Time",
                                                            description: description)
        let timeRow: SimpleTimerRow = .time(viewModel: eventTimeCellViewModel)
        // Count Up/Down Segment
        let countingType = event.rx.observe(CountingType.self, "countingType")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountType: countingType)
        let countTypeRow: SimpleTimerRow = .countType(viewModel: eventCountTypeCellViewModel)
        return [SimpleTimerSection(items: [timeRow, countTypeRow])]
    }
}
