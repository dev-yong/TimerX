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

public protocol ActionCombinationUseCase {
    func add(_ actionCombination: ActionCombination,
             update: Bool) -> Observable<Void>
    func actionCombinations() -> Observable<[ActionCombination]>
    func actionCombination(of uuid: String) -> Observable<ActionCombination?>
    func delete(_ actionCombination: ActionCombination) -> Observable<Void>
}
