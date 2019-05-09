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

final class CountingEventCellViewModel: EventCellViewMdoel {
    struct Input {
        let rowSelection: Driver<CountingEventRow>
        let countSelectionTrigger: Driver<Int>
    }
    struct Output {
        let title: Driver<String>
        let sections: Driver<[CountingEventSection]>
        let timeRowSelection: Driver<Void>
    }
    private var disposeBag = DisposeBag()
    private let countingEvent: NSCountingEvent
    private let sections = BehaviorRelay(value: [CountingEventSection]())
    private let selectedCountSegment = BehaviorRelay<CountingType>(value: .up)
    private let showTimePicker = BehaviorRelay(value: false)
    init(countingEvent: NSCountingEvent) {
        self.countingEvent = countingEvent
    }
    func transform(_ input: Input) -> Output {
        let countSelectionTrigger = input.countSelectionTrigger.asDriver()
            .map { CountingType(rawValue: $0) ?? .up }
        countSelectionTrigger.drive(onNext: { [weak self] in
            self?.countingEvent.countingType = $0
        }).disposed(by: disposeBag)
        let timeRowSelecionTrigger = input.rowSelection.asDriver()
            .filter {
                switch $0 {
                case .time: return true
                default: return false
                }
            }.do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showTimePicker.accept(!self.showTimePicker.value)
            }).mapToVoid()
        showTimePicker.asDriver()
            .map { [weak self] in
                self?.makeEventCellSections(showTimePicker: $0) ?? []
            }
            .drive(sections)
            .disposed(by: disposeBag)
        return Output(title: Driver.just("Counting event timer"),
                      sections: sections.asDriver(),
                      timeRowSelection: timeRowSelecionTrigger)
    }
    private func makeEventCellSections(showTimePicker: Bool) -> [CountingEventSection] {
        // Time or Interval
        let interval = countingEvent.rx.observe(TimeInterval.self, "interval").unwrap()
            .asDriverOnErrorJustComplete()
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Interval",
                                                            second: interval)
        let timeRow: CountingEventRow = .time(viewModel: eventTimeCellViewModel)
        // TimePicker
        let eventTimePickerCellViewModel = EventTimePickerCellViewModel()
        let timePickerRow: CountingEventRow = .timePicker(viewModel: eventTimePickerCellViewModel)
        // Count Up/Down Segment
        let countingType = countingEvent.rx.observe(CountingType.self, "countingType").unwrap()
            .asDriverOnErrorJustComplete()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountingType: countingType)
        let countTypeRow: CountingEventRow = .countType(viewModel: eventCountTypeCellViewModel)
        var rows = [timeRow, countTypeRow]
        if showTimePicker {
            rows.insert(timePickerRow, after: timeRow)
        }
        return [CountingEventSection(items: rows)]
    }
}
