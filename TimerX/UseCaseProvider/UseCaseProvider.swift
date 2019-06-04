//
//  UseCaseProvider.swift
//  TimerX
//
//  Created by 이광용 on 03/06/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import Domain

struct TestUseCaseProvider: Domain.UseCaseProvider {
    func makeRoadMapUseCase() -> RoadMapUseCase {
        return TestRoadMapUseCase()
    }
    
    func makeActionUseCase() -> ActionUseCase {
        return TestActionUseCase()
    }
}
struct TestRoadMapUseCase: Domain.RoadMapUseCase {
    func add(_ roadMap: RoadMap, update: Bool) -> Observable<Void> {
        return .empty()
    }
    func roadMaps() -> Observable<[RoadMap]> {
        return .empty()
    }
    func roadMap(of uuid: String) -> Observable<RoadMap?> {
        return .empty()
    }
    func delete(_ roadMap: RoadMap) -> Observable<Void> {
        return .empty()
    }
}

struct TestActionUseCase: Domain.ActionUseCase {
    func add(_ action: Actionable, update: Bool) -> Observable<Void> {
        return .empty()
    }
    func actions() -> Observable<[Actionable]> {
        return .empty()
    }
    func action(of uuid: String) -> Observable<Actionable?> {
        return .empty()
    }
    func delete(_ action: Actionable) -> Observable<Void> {
        return .empty()
    }
}
