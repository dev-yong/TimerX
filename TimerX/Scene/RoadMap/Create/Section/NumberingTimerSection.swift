//
//  CountingEventSection.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct NumberingTimerSection {
    var items: [NumberingTimerRow]
    init(items: [NumberingTimerRow]) {
        self.items = items
    }
}
extension NumberingTimerSection: SectionModelType {
    init(original: NumberingTimerSection,
         items: [NumberingTimerRow]) {
        self = original
        self.items = items
    }
}

enum NumberingTimerRow {
    case goal(viewModel: EventGoalCellViewModel)
    case time(viewModel: EventTimeCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
