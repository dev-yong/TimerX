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

final class SimpleEventCellViewModel: EventCellViewMdoelProtocol {
    struct Input: EventCellViewModelInputProtocol {
        let rowSelectionTrigger: Driver<SimpleEventRow>
        let countSegmentSelectionTrigger: Driver<Int>
    }
    struct Output: EventCellViewModelOutputProtocool {
        let title: Driver<String>
        let sections: Driver<[SimpleEventSection]>
        let countSegmentSelection: Driver<Void>
    }
    let event: NSSimpleEvent
    private let showTimePicker = BehaviorRelay(value: false)
    init(event: NSSimpleEvent) {
        self.event = event
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
    private func makeEventCellSections() -> [SimpleEventSection] {
        // Time or Interval
        let seconds = event.rx.observe(TimeInterval.self, "seconds")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let description = seconds
            .map { Time(timeInterval: $0) }
            .map { $0.description }
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Time",
                                                            description: description)
        let timeRow: SimpleEventRow = .time(viewModel: eventTimeCellViewModel)
        // Count Up/Down Segment
        let countingType = event.rx.observe(CountingType.self, "countingType")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountType: countingType)
        let countTypeRow: SimpleEventRow = .countType(viewModel: eventCountTypeCellViewModel)
        return [SimpleEventSection(items: [timeRow, countTypeRow])]
    }
}
