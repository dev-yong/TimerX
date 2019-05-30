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

public protocol RoadMapUseCase {
    func add(_ roadMap: RoadMap,
             update: Bool) -> Observable<Void>
    func roadMaps() -> Observable<[RoadMap]>
    func roadMap(of uuid: String) -> Observable<RoadMap?>
    func delete(_ roadMap: RoadMap) -> Observable<Void>
}
