//
//  EventGoalCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxCocoa
import Domain

final class EventGoalCellViewModel {
    let countingEvent: NSCountingEvent
    let title: Driver<String>
    let goal: Driver<String>
    init(countingEvent: NSCountingEvent) {
        self.countingEvent = countingEvent
        title = Driver.just("Goal")
        goal = countingEvent.rx.observe(TimeInterval.self, "goal").unwrap()
            .map { Int($0) }
            .map { String(describing: $0) }
            .asDriverOnErrorJustComplete()
    }
}
