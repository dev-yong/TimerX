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
        let timeIntervalSelectionTrigger: Driver<TimeInterval>
        let countSegmentSelectionTrigger: Driver<Int>
    }
    struct Output: EventCellViewModelOutputProtocool {
        let title: Driver<String>
        let sections: Driver<[SimpleEventSection]>
        let timeRowSelection: Driver<Void>
        let showTimePicker: Driver<Void>
        let timeIntervalSelection: Driver<Void>
        let countSegmentSelection: Driver<Void>
    }
    private let simpleEvent: NSSimpleEvent
    private let sections = BehaviorRelay(value: [SimpleEventSection]())
    private let showTimePicker = BehaviorRelay(value: false)
    init(simpleEvent: NSSimpleEvent) {
        self.simpleEvent = simpleEvent
    }
    func transform(_ input: Input) -> Output {
        let timeRowSelecionTrigger = input.rowSelectionTrigger.asDriver()
        .filter {
            switch $0 {
            case .time: return true
            default: return false
            }
        }.do(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.showTimePicker.accept(!self.showTimePicker.value)
        }).mapToVoid()
        let showTimePicker = self.showTimePicker.asDriver()
            .map { [weak self] in
                self?.makeEventCellSections(showTimePicker: $0) ?? []
            }.do(onNext: { [weak self] in
                self?.sections.accept($0)
            }).mapToVoid()
        let timeIntervalSelection = input.timeIntervalSelectionTrigger
            .do(onNext: { [weak self] in
                self?.simpleEvent.seconds = $0
            }).mapToVoid()
        let countSegmentSelection = input.countSegmentSelectionTrigger
            .map { CountingType(rawValue: $0) ?? .up }
            .do(onNext: { [weak self] in
                self?.simpleEvent.countingType = $0
            }).mapToVoid()
        return Output(title: Driver.just("Simple"),
                      sections: sections.asDriver(),
                      timeRowSelection: timeRowSelecionTrigger,
                      showTimePicker: showTimePicker,
                      timeIntervalSelection: timeIntervalSelection,
                      countSegmentSelection: countSegmentSelection)
    }
    private func makeEventCellSections(showTimePicker: Bool) -> [SimpleEventSection] {
        // Time or Interval
        let seconds = simpleEvent.rx.observeWeakly(TimeInterval.self, "seconds")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let description = seconds
            .map { Time(timeInterval: $0) }
            .map { $0.description }
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Time",
                                                            description: description)
        let timeRow: SimpleEventRow = .time(uuid: simpleEvent.uuid,
                                            viewModel: eventTimeCellViewModel)
        // TimePicker
        let eventTimePickerCellViewModel = EventTimePickerCellViewModel(timeInterval: seconds)
        let timePickerRow: SimpleEventRow = .timePicker(uuid: simpleEvent.uuid,
                                                        viewModel: eventTimePickerCellViewModel)
        // Count Up/Down Segment
        let countingType = simpleEvent.rx.observeWeakly(CountingType.self, "countingType")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountType: countingType)
        let countTypeRow: SimpleEventRow = .countType(uuid: simpleEvent.uuid,
                                                      viewModel: eventCountTypeCellViewModel)
        var rows = [timeRow, timePickerRow, countTypeRow]
//        if showTimePicker {
//            rows.insert(timePickerRow, after: timeRow)
//        }
        return [SimpleEventSection(uuid: simpleEvent.uuid,
                                   items: rows)]
    }
}
