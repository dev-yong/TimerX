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

final class SimpleEventCellViewModel: EventCellViewMdoel {
    struct Input {
        let rowSelection: Driver<SimpleEventRow>
        let countSelectionTrigger: Driver<Int>
    }
    struct Output {
        let title: Driver<String>
        let sections: Driver<[SimpleEventSection]>
        let timeRowSelection: Driver<Void>
    }
    private var disposeBag = DisposeBag()
    private let simpleEvent: NSSimpleEvent
    private let sections = BehaviorRelay(value: [SimpleEventSection]())
    private let selectedCountSegment = BehaviorRelay<CountingType>(value: .up)
    private let showTimePicker = BehaviorRelay(value: false)
    init(simpleEvent: NSSimpleEvent) {
        self.simpleEvent = simpleEvent
    }
    func transform(_ input: Input) -> Output {
        let countSelectionTrigger = input.countSelectionTrigger.asDriver()
            .map { CountingType(rawValue: $0) ?? .up }
        countSelectionTrigger.drive(onNext: { [weak self] in
            self?.simpleEvent.countingType = $0
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
        return Output(title: Driver.just("Simple event timer"),
                      sections: sections.asDriver(),
                      timeRowSelection: timeRowSelecionTrigger)
    }
    private func makeEventCellSections(showTimePicker: Bool) -> [SimpleEventSection] {
        // Time or Interval
        let seconds = simpleEvent.rx.observe(TimeInterval.self, "seconds").unwrap()
            .asDriverOnErrorJustComplete()
        let eventTimeCellViewModel = EventTimeCellViewModel(title: "Time",
                                                            second: seconds)
        let timeRow: SimpleEventRow = .time(viewModel: eventTimeCellViewModel)
        // TimePicker
        let eventTimePickerCellViewModel = EventTimePickerCellViewModel()
        let timePickerRow: SimpleEventRow = .timePicker(viewModel: eventTimePickerCellViewModel)
        // Count Up/Down Segment
        let countingType = simpleEvent.rx.observe(CountingType.self, "countingType").unwrap()
            .asDriverOnErrorJustComplete()
        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(selectedCountingType: countingType)
        let countTypeRow: SimpleEventRow = .countType(viewModel: eventCountTypeCellViewModel)
        var rows = [timeRow, countTypeRow]
        if showTimePicker {
            rows.insert(timePickerRow, after: timeRow)
        }
        return [SimpleEventSection(items: rows)]
    }
}
