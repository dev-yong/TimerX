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
    func add(_ action: Actionable,
             update: Bool) -> Observable<Void>
    func actions() -> Observable<[Actionable]>
    func action(of uuid: String) -> Observable<Actionable?>
    func delete(_ action: Actionable) -> Observable<Void>
}
