//
//  EventCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class EventCellViewModel {
    init() {
        let eventSelectionTrigger = PublishRelay<EventType>()
        let eventSegments = EventType.allCases
        let countSegments = CountingType.allCases
        let selectedTime = BehaviorRelay(value: Time(minute: 10, second: 0))
        
    }
}
