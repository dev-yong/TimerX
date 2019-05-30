//
//  CombinationCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Domain
import Coordinator

enum RoadMapRoute: Route {
    case roadMaps
    case create
    case edit
    case player
}

final class RoadMapCoordinator: NaivgationCoordinator<RoadMapRoute> {
    private let useCaseProvider: Domain.UseCaseProvider
    private var storyboard: UIStoryboard {
        return Storyboard.roadMap.instance
    }
    init(useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        super.init(root: .roadMaps)
    }
    override func coordinate(_ route: RoadMapRoute) {
        let roadMapUseCase = useCaseProvider.makeRoadMapUseCase()
        let actionUseCase = useCaseProvider.makeActionUseCase()
        switch route {
        case .roadMaps:
            let viewController = storyboard.instantiate(viewController: RoadMapsViewController.self)
            let viewModel = RoadMapsViewModel(roadMapUseCase: roadMapUseCase,
                                              coordinator: self)
            viewController.viewModel = viewModel
            rootViewController?.pushViewController(viewController, animated: true)
        case .create:
            let viewController = storyboard.instantiate(viewController: RoadMapCreateViewController.self)
            
            viewController.viewModel = RoadMapCreateViewModel(roadMapUseCase: roadMapUseCase,
                                                              actionUseCase: actionUseCase,
                                                              coordinator: self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .edit:
            let viewController = storyboard.instantiate(viewController: RoadMapEditViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .player:
            let viewcontoller = storyboard.instantiate(viewController: RoadMapPlayerViewController.self)
            rootViewController.present(viewcontoller,
                                       animated: true,
                                       completion: nil)
        }
    }
}
