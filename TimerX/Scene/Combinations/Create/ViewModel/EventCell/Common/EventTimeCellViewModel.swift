//
//  EventTimerCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxCocoa
import Domain

final class EventTimeCellViewModel {
    let title: Driver<String>
    let description: Driver<String>
    init(title: String,
         second: Driver<TimeInterval>) {
        self.title = Driver.just(title)
        description = second.map { Time(second: $0) }
            .map { $0.description }
    }
}
//let timeEventTimeInterval = timeEvent.rx.observe(TimeInterval.self, "seconds").unwrap()
//let countingEventInterval = countingEvent.rx.observe(TimeInterval.self, "interval").unwrap()
