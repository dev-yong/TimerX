//
//  CombinationCellViewModel.swift
//  TimerX
//
//  Created by 이광용 on 22/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxCocoa
final class CombinationCellViewModel {
    let combination: EventCombination
    let title: Driver<String?>
    let description: Driver<String?>
    init(combination: EventCombination) {
        self.combination = combination
        self.title = Driver.just(self.combination.title)
        description = Driver.just(combination.events.map {
            $0.uuid
        }.joined(separator: "\n"))
    }
}
