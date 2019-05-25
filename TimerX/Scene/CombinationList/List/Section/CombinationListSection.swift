//
//  CombinationSection.swift
//  TimerX
//
//  Created by 이광용 on 22/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct CombinationListSection: SectionModelType {
    var items: [CombinationListRow]
    init(items: [CombinationListRow]) {
        self.items = items
    }
    init(original: CombinationListSection,
         items: [CombinationListRow]) {
        self = original
        self.items = items
    }
}

struct CombinationListRow {
    let viewModel: CombinationCellViewModel
}
