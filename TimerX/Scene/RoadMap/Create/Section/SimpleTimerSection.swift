//
//  SimpleEventSection.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct SimpleTimerSection {
    var items: [SimpleTimerRow]
    init(items: [SimpleTimerRow]) {
        self.items = items
    }
}
extension SimpleTimerSection: SectionModelType {
    init(original: SimpleTimerSection,
         items: [SimpleTimerRow]) {
        self = original
        self.items = items
    }
}

enum SimpleTimerRow {
    case time(viewModel: EventTimeCellViewModel)
    case countType(viewModel: EventCountTypeCellViewModel)
}
