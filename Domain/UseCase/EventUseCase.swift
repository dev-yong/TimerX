//
//  EventUseCase.swift
//  Domain
//
//  Created by 이광용 on 23/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol EventUseCase {
    func add<Event: AbstractEvent>(_ event: Event,
                                   update: Bool) -> Observable<Void>
    func events<Event: AbstractEvent>() -> Observable<[Event]>
    func event<Event: AbstractEvent>(of uuid: String) -> Observable<Event?>
    func delete<Event: AbstractEvent>(_ event: Event) -> Observable<Void>
}
