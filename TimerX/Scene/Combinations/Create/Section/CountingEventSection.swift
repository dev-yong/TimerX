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
        return uuid
    }
    let uuid: String
    var items: [CountingEventRow]
    init(uuid: String,
         items: [CountingEventRow]) {
        self.uuid = uuid
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
    case goal(uuid: String, viewModel: EventGoalCellViewModel)
    case time(uuid: String, viewModel: EventTimeCellViewModel)
    case timePicker(uuid: String, viewModel: EventTimePickerCellViewModel)
    case countType(uuid: String, viewModel: EventCountTypeCellViewModel)
}
extension CountingEventRow: IdentifiableType, Equatable {
    var identity: String {
        switch self {
        case let .goal(uuid, _): return uuid + "Goal"
        case let .time(uuid, _): return uuid + "Time"
        case let .timePicker(uuid, _): return uuid + "TimePicker"
        case let .countType(uuid, _): return uuid + "CountType"
        }
    }
    static func == (lhs: CountingEventRow,
                    rhs: CountingEventRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
