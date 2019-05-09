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
        return String(describing: self)
    }
    var items: [SimpleEventRow]
    init(items: [SimpleEventRow]) {
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
    case time(viewModel: EventTimeCellViewModel)
    case timePicker(viewModel: EventTimePickerCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
extension SimpleEventRow: IdentifiableType, Equatable {
    var identity: String {
        switch self {
        case .time: return "Time"
        case .timePicker: return "TimePicker"
        case .countType: return "CountType"
        }
    }
    static func == (lhs: SimpleEventRow,
                    rhs: SimpleEventRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
