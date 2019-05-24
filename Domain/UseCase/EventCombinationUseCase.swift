//
//  EventCombinationUseCase.swift
//  Domain
//
//  Created by 이광용 on 14/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol EventCombinationUseCase {
    func add(_ eventCombination: EventCombination,
             update: Bool) -> Observable<Void>
    func eventCombinations() -> Observable<[EventCombination]>
    func eventCombination(of uuid: String) -> Observable<EventCombination?>
    func delete(_ eventCombination: EventCombination) -> Observable<Void>
}
