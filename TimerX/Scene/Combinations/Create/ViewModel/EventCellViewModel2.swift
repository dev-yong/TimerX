////
////  EventCellViewModel.swift
////  TimerX
////
////  Created by 이광용 on 02/05/2019.
////  Copyright © 2019 GwangYongLee. All rights reserved.
////
//
//import Foundation
//import Domain
//import RxSwift
//import RxCocoa
//
//final class EventCellViewModel: ViewModelProtocol {
//    struct Input {
//        let rowSelection: Driver<EventCellRow>
//        let eventSelectionTrigger: Driver<Int>
//        let countSelectionTrigger: Driver<Int>
//    }
//    struct Output {
//        let sections: Driver<[EventCellSection]>
//        let timeRowSelection: Driver<Void>
//    }
//    private var disposeBag = DisposeBag()
//    let uuid: String
//    private let timerEvent: NSSimpleEvent
//    private let countingEvent: NSCountingEvent
//    private let sections = BehaviorRelay(value: [EventCellSection]())
//    private let selectedEventSegment = BehaviorRelay<EventType>(value: .simple)
//    private let selectedCountSegment = BehaviorRelay<CountingType>(value: .up)
//    private let selectedTime = BehaviorRelay(value: Time(minute: 10, second: 0))
//    private let showTimePicker = BehaviorRelay(value: false)
//    init(uuid: String) {
//        self.uuid = uuid
//        self.timerEvent = SimpleEvent(uuid: uuid,
//                                    seconds: 60,
//                                    countingType: .up).asNSObject()
//        self.countingEvent = CountingEvent(uuid: uuid,
//                                           goal: 10,
//                                           interval: 1,
//                                           countingType: .up).asNSObject()
//    }
//    func transform(_ input: EventCellViewModel.Input) -> EventCellViewModel.Output {
//        input.eventSelectionTrigger.map { EventType(rawValue: $0) ?? .simple }
//            .drive(selectedEventSegment)
//            .disposed(by: disposeBag)
//        let countSelectionTrigger = input.countSelectionTrigger.asDriver()
//            .map { CountingType(rawValue: $0) ?? .up }
//        countSelectionTrigger.withLatestFrom(selectedEventSegment.asDriver()) { ($0, $1) }
//            .drive(onNext: { [weak self] in
//                switch $0.1 {
//                case .simple: self?.timerEvent.countingType = $0.0
//                case .counting: self?.countingEvent.countingType = $0.0
//                }
//            }).disposed(by: disposeBag)
//        let timeRowSelectionTrigger = input.rowSelection.asDriver()
//            .filter {
//                switch $0 {
//                case .time: return true
//                default: return false
//                }
//            }
//            .mapToVoid()
//            .do(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.showTimePicker.accept(!self.showTimePicker.value)
//            })
//        Driver.combineLatest(selectedEventSegment.asDriver(), showTimePicker.asDriver())
//            .map { [weak self] in
//                self?.makeEventCellSections(selectedEvent: $0.0, showTimePicker: $0.1) ?? []
//            }.drive(sections)
//            .disposed(by: disposeBag)
////        showTimePicker.asDriver().map { [weak self] in
////            guard let self = self else { return [] }
////            return self.makeEventCellSections(showTimePicker: $0)
////        }.drive(sections)
////        .disposed(by: disposeBag)
//
//        return Output(sections: sections.asDriver(),
//                      timeRowSelection: timeRowSelectionTrigger)
//    }
//    private func makeEventCellSections(selectedEvent: EventType,
//                                       showTimePicker: Bool = false) -> [EventCellSection] {
//        // EventTypeRow
//        let eventTypeCellViewModel = EventTypeCellViewModel(uuid: uuid,
//                                                            selectedEventSegment: selectedEvent)
//        let eventTypeRow: EventCellRow = .eventType(viewModel: eventTypeCellViewModel)
//        // Goal
//        let eventGoalCellViewModel = EventGoalCellViewModel(countingEvent: countingEvent)
//        let goalRow: EventCellRow = .goal(viewModel: eventGoalCellViewModel)
//        // Time or Interval
//        let eventTimeCellViewModel = EventTimeCellViewModel(timeEvent: timerEvent,
//                                                            countingEvent: countingEvent,
//                                                            selectedEventSegment: selectedEvent)
//        let timeRow: EventCellRow = .time(viewModel: eventTimeCellViewModel)
//        // TimePicker
//        let eventTimePickerCellViewModel = EventTimePickerCellViewModel(timeEvent: timerEvent,
//                                                                        countingEvent: countingEvent,
//                                                                        selectedEventSegment: selectedEvent)
//        let timePickerRow: EventCellRow = .timePicker(viewModel: eventTimePickerCellViewModel)
//        // Count Up/Down Segment
//        let eventCountTypeCellViewModel = EventCountTypeCellViewModel(timeEvent: timerEvent,
//                                                                 countingEvent: countingEvent,
//                                                                 selectedEventSegment: selectedEvent)
//        let countTypeRow: EventCellRow = .countType(viewModel: eventCountTypeCellViewModel)
//        var rows: [EventCellRow] = [eventTypeRow, timeRow, countTypeRow]
//        if showTimePicker {
//            rows.insert(timePickerRow, after: timeRow)
//        }
//        switch selectedEvent {
//        case .simple: break
//        case .counting: rows.insert(goalRow, after: eventTypeRow)
//        }
//        return [EventCellSection(items: rows)]
//    }
//}
