//
//  CombinationSection.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
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
    case simple(uuid: String,
        viewModel: SimpleEventCellViewModel)
    case counting(uuid: String,
        viewModel: CountingEventCellViewModel)
    var identity: String {
        switch self {
        case let .simple(uuid, _): return uuid
        case let .counting(uuid, _): return uuid
        }
    }
    static func == (lhs: CombinationRow, rhs: CombinationRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
