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
final class RoadMapCellViewModel {
    let roadMap: RoadMap
    let title: Driver<String?>
    let description: Driver<String?>
    init(roadMap: RoadMap) {
        self.roadMap = roadMap
        self.title = Driver.just(self.roadMap.title)
        description = Driver.just(self.roadMap.actions.map {
            $0.uuid
        }.joined(separator: "\n"))
    }
}
