//
//  CountingEventUseCase.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol EventCombinationUseCase {
    func add(_ eventCombination: EventCombination) -> EventCombination
    func eventCombinations() -> [EventCombination]
    func eventCombination(of uuid: String) -> EventCombination?
    func update(_ eventCombination: EventCombination) -> EventCombination
    func delete(_ eventCombination: EventCombination) -> EventCombination
}
