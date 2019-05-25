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
    var items: [SimpleEventRow]
    init(items: [SimpleEventRow]) {
        self.items = items
    }
}
extension SimpleEventSection: SectionModelType {
    init(original: SimpleEventSection,
         items: [SimpleEventRow]) {
        self = original
        self.items = items
    }
}

enum SimpleEventRow {
    case time(viewModel: EventTimeCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
