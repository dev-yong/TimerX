//
//  EventTypeCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxCocoa

final class EventTypeCellViewModel {
    let eventSegments: Driver<[String?]>
    init(eventSegments: [Domain.EventType]) {
        self.eventSegments = Driver.just(eventSegments.map { $0.description })
    }
}
