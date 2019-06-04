//
//  ActionUseCase.swift
//  Domain
//
//  Created by 이광용 on 23/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ActionUseCase {
    func add(_ action: Action,
             update: Bool) -> Observable<Void>
    func actions() -> Observable<[Action]>
    func action(of uuid: String) -> Observable<Action?>
    func delete(_ action: Action) -> Observable<Void>
}
