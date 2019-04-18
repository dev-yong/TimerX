//
//  CountingEventUseCase.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol EventCombinationUseCase {
    // Create
    func add(_ eventCombination: EventCombination) -> EventCombination
    // Read
    func eventCombinations() -> [EventCombination]
    func eventCombination(of uuid: String) -> EventCombination?
    // Update
    func update(_ eventCombination: EventCombination) -> EventCombination
    // Delete
    func delete(_ eventCombination: EventCombination) -> EventCombination
}
