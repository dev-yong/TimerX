//
//  SimpleEventSection.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct SimpleEventSection {
    var identity: String {
        return uuid
    }
    let uuid: String
    var items: [SimpleEventRow]
    init(uuid: String,
         items: [SimpleEventRow]) {
        self.uuid = uuid
        self.items = items
    }
}
extension SimpleEventSection: AnimatableSectionModelType {
    init(original: SimpleEventSection,
         items: [SimpleEventRow]) {
        self = original
        self.items = items
    }
}

enum SimpleEventRow {
    case time(uuid: String, viewModel: EventTimeCellViewModel)
    case timePicker(uuid: String, viewModel: EventTimePickerCellViewModel)
    case countType(uuid: String, viewModel: EventCountTypeCellViewModel)
}
extension SimpleEventRow: IdentifiableType, Equatable {
    var identity: String {
        switch self {
        case let .time(uuid, _): return uuid + "Time"
        case let .timePicker(uuid, _): return uuid + "TimePicker"
        case let .countType(uuid, _): return uuid + "CountType"
        }
    }
    static func == (lhs: SimpleEventRow,
                    rhs: SimpleEventRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
