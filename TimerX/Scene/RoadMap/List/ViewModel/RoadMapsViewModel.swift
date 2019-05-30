//
//  CombinationListViewModel.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

final class RoadMapsViewModel: ViewModelProtocol {
    struct Input {
        let trigger: Driver<Void>
        let createRoadMapTrigger: Driver<Void>
    }
    struct Output {
        let createRoadMap: Driver<Void>
        let roadMapsSections: Driver<[RoadMapsSection]>
    }
    private let roadMapUseCase: RoadMapUseCase
    private let coordinator: RoadMapCoordinator
    init(roadMapUseCase: RoadMapUseCase,
         coordinator: RoadMapCoordinator) {
        self.roadMapUseCase = roadMapUseCase
        self.coordinator = coordinator
    }
    func transform(_ input: RoadMapsViewModel.Input) -> RoadMapsViewModel.Output {
        let createCombination = input.createRoadMapTrigger.do(onNext: { [weak self] in
            self?.coordinator.coordinate(.create)
        })
        let roadMapsSections = roadMapUseCase.roadMaps()
            .asDriver(onErrorJustReturn: [])
            .map {
                $0.map { RoadMapCellViewModel(roadMap: $0) }
                .map { RoadMapsRow(viewModel: $0) }
            }
            .map { [RoadMapsSection(items: $0)] }
        return Output(createRoadMap: createCombination,
                      roadMapsSections: roadMapsSections)
    }
}
