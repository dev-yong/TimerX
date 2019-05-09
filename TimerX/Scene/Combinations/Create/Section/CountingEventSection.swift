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
    var identity: String {
        return String(describing: self)
    }
    var items: [CountingEventRow]
    init(items: [CountingEventRow]) {
        self.items = items
    }
}
extension CountingEventSection: AnimatableSectionModelType {
    init(original: CountingEventSection,
         items: [CountingEventRow]) {
        self = original
        self.items = items
    }
}

enum CountingEventRow {
    case goal(viewModel: EventGoalCellViewModel)
    case time(viewModel: EventTimeCellViewModel)
    case timePicker(viewModel: EventTimePickerCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
extension CountingEventRow: IdentifiableType, Equatable {
    var identity: String {
        switch self {
        case .goal: return "Goal"
        case .time: return "Time"
        case .timePicker: return "TimePicker"
        case .countType: return "CountType"
        }
    }
    static func == (lhs: CountingEventRow,
                    rhs: CountingEventRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
