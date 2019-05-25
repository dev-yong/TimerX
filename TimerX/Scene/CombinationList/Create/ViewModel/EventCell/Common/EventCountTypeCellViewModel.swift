//
//  EventCountTypeCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class EventCountTypeCellViewModel {
    let title: Driver<String>
    private let countingTypes = CountingType.allCases
    let countingSegemnts: Driver<[String?]>
    let selectedCountType: Driver<Int>
    init(selectedCountType: Driver<CountingType>) {
        title = Driver.just("Count")
        countingSegemnts = Driver.just(countingTypes.map { $0.description })
        self.selectedCountType = selectedCountType.map { $0.rawValue }
    }
}
