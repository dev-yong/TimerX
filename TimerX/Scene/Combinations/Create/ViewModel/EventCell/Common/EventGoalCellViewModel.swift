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
    let title: Driver<String>
    let goal: Driver<String>
    init(goal: Driver<Int>) {
        title = Driver.just("Goal")
        self.goal = goal.map { String(describing: $0) }
    }
}
