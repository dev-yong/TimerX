
//
//  EventTimePickerCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxCocoa

final class EventTimePickerCellViewModel {
    let time: Driver<Time>
    init(time: Driver<Time>) {
        self.time = time
    }
}
