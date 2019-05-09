//
//  EventCountTypeCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxCocoa

final class EventCountTypeCellViewModel {
    let title: Driver<String>
    let selectedCountingType: Driver<Int>
    let countSegments: Driver<[String?]>
    init(selectedCountingType: Driver<CountingType>) {
        title = Driver.just("Count")
        countSegments = Driver.just(CountingType.allCases.map { $0.description })
        self.selectedCountingType = selectedCountingType.map { $0.rawValue }
    }
}

//let timeEventCountingType = timeEvent.rx.observe(CountingType.self, "countingType").unwrap()
//let countingEventCountingType = countingEvent.rx.observe(CountingType.self, "countingType").unwrap()
