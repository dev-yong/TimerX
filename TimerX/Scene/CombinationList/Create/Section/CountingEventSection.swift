//
//  CountingEventSection.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct CountingEventSection {
    var items: [CountingEventRow]
    init(items: [CountingEventRow]) {
        self.items = items
    }
}
extension CountingEventSection: SectionModelType {
    init(original: CountingEventSection,
         items: [CountingEventRow]) {
        self = original
        self.items = items
    }
}

enum CountingEventRow {
    case goal(viewModel: EventGoalCellViewModel)
    case time(viewModel: EventTimeCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
