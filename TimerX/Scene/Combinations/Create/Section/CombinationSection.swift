//
//  CombinationSection.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxDataSources

struct CombinationSection: AnimatableSectionModelType {
    var identity: String {
        return "CombinationSection"
    }
    var items: [CombinationRow]
    init(items: [CombinationRow]) {
        self.items = items
    }
    init(original: CombinationSection, items: [CombinationRow]) {
        self = original
        self.items = items
    }
}

enum CombinationRow: IdentifiableType, Equatable {
    case simple(viewModel: SimpleEventCellViewModel)
    case counting(viewModel: CountingEventCellViewModel)
    var identity: String {
        return event.uuid
    }
    var event: NSEvent {
        switch self {
        case .simple(let viewModel):
            return viewModel.event
        case .counting(let viewModel):
            return viewModel.event
        }
    }
    static func == (lhs: CombinationRow, rhs: CombinationRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
