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

final class CountingEventCellViewModel: EventCellViewMdoelProtocol {
    struct Input: EventCellViewModelInputProtocol {
        let rowSelectionTrigger: Driver<CountingEventRow>
        let timeIntervalSelectionTrigger: Driver<TimeInterval>
        let countSegmentSelectionTrigger: Driver<Int>
    }
    struct Output: EventCellViewModelOutputProtocool {
        let title: Driver<String>
        let sections: Driver<[CountingEventSection]>
        let timeRowSelection: Driver<Void>
        let showTimePicker: Driver<Void>
        let timeIntervalSelection: Driver<Void>
        let countSegmentSelection: Driver<Void>
    }
    private let countingEvent: NSCountingEvent
    private let sections = BehaviorRelay(value: [CountingEventSection]())
    private let showTimePicker = BehaviorRelay(value: false)
    init(countingEvent: NSCountingEvent) {
        self.countingEvent = countingEvent
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
                self?.countingEvent.interval = $0
            }).mapToVoid()
        let countSegmentSelection = input.countSegmentSelectionTrigger
            .map { CountingType(rawValue: $0) ?? .up }
            .do(onNext: { [weak self] in
                self?.countingEvent.countingType = $0
            }).mapToVoid()
        return Output(title: Driver.just("Counting"),
                      sections: sections.asDriver(),
                      timeRowSelection: timeRowSelecionTrigger,
                      showTimePicker: showTimePicker,
                      timeIntervalSelection: timeIntervalSelection,
                      countSegmentSelection: countSegmentSelection)
    }
    private func makeEventCellSections(showTimePicker: Bool) -> [CountingEventSection] {
        // Goal
        let goal = countingEvent.rx.observeWeakly(Int.self, "goal")
            .asDriverOnErrorJustComplete()
            .unwrap()
            .distinctUntilChanged()
        let eventGoalCellViewModel = EventGoalCellViewModel(goal: goal)
        let goalRow: CountingEventRow = .goal(uuid: countingEvent.uuid,
                                              viewModel: eventGoalCellViewModel)
        // Time or Interval
        let interval = countingEvent.rx.observeWeakly(TimeInterval.self, "interval")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let description = interval
            .map { Time(timeInterval: $0) }
            .map { String(format: "%0.2d:%0.2d:%0.2d", $0.hours, $0.minutes, $0.seconds) }
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Interval",
                                                            description: description)
        let timeRow: CountingEventRow = .time(uuid: countingEvent.uuid,
                                              viewModel: eventTimeCellViewModel)
        // TimePicker
        let eventTimePickerCellViewModel = EventTimePickerCellViewModel(timeInterval: interval)
        let timePickerRow: CountingEventRow = .timePicker(uuid: countingEvent.uuid,
                                                          viewModel: eventTimePickerCellViewModel)
        // Count Up/Down Segment
        let countingType = countingEvent.rx.observeWeakly(CountingType.self, "countingType")
            .asDriverOnErrorJustComplete()
            .unwrap()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountType: countingType)
        let countTypeRow: CountingEventRow = .countType(uuid: countingEvent.uuid,
                                                        viewModel: eventCountTypeCellViewModel)
        var rows = [goalRow, timeRow, timePickerRow, countTypeRow]
//        if showTimePicker {
//            rows.insert(timePickerRow, after: timeRow)
//        }
        return [CountingEventSection(uuid: countingEvent.uuid,
                                     items: rows)]
    }
}
