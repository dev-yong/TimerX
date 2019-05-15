//
//  RxEventCombinationUseCase.swift
//  Domain
//
//  Created by 이광용 on 14/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol RxEventCombinationUseCase {
    func add(_ eventCombination: EventCombination) -> Observable<Void>
    func eventCombinations() -> Observable<EventCombination>
    func eventCombination(of uuid: String) -> Observable<EventCombination?>
    func update(_ eventCombination: EventCombination) -> Observable<Void>
    func delete(_ eventCombination: EventCombination) -> Observable<Void>
}
