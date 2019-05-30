//
//  CombinationSection.swift
//  TimerX
//
//  Created by 이광용 on 22/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxDataSources

struct RoadMapsSection: SectionModelType {
    var items: [RoadMapsRow]
    init(items: [RoadMapsRow]) {
        self.items = items
    }
    init(original: RoadMapsSection,
         items: [RoadMapsRow]) {
        self = original
        self.items = items
    }
}

struct RoadMapsRow {
    let viewModel: RoadMapCellViewModel
}
