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

struct RoadMapSection: AnimatableSectionModelType {
    var identity: String {
        return String(describing: self)
    }
    var items: [RoadMapRow]
    init(items: [RoadMapRow]) {
        self.items = items
    }
    init(original: RoadMapSection, items: [RoadMapRow]) {
        self = original
        self.items = items
    }
}

enum RoadMapRow: IdentifiableType, Equatable {
    case loop
    case simpleTimer(viewModel: SimpleTimerCellViewModel)
    case numberingTimer(viewModel: NumberingTimerCellViewModel)
    var identity: String {
        return action?.uuid ?? ""
    }
    var action: Action? {
        switch self {
        case .loop:
            return nil
        case .simpleTimer(let viewModel):
            return viewModel.action
        case .numberingTimer(let viewModel):
            return viewModel.action
        }
    }
    static func == (lhs: RoadMapRow, rhs: RoadMapRow) -> Bool {
        return lhs.identity == rhs.identity
    }
}
