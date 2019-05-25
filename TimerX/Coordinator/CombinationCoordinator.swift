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

enum CombinationRoute: Route {
    case combinations
    case create
    case edit
    case player
}

final class CombinationCoordinator: NaivgationCoordinator<CombinationRoute> {
    private let useCaseProvider: Domain.UseCaseProvider
    private var storyboard: UIStoryboard {
        return Storyboard.combination.instance
    }
    init(useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        super.init(root: .combinations)
    }
    override func coordinate(_ route: CombinationRoute) {
        let combinationUseCase = useCaseProvider.makeEventCombinationUseCase()
        let eventUseCase = useCaseProvider.makeEventUseCase()
        switch route {
        case .combinations:
            let viewController = storyboard.instantiate(viewController: CombinationListViewController.self)
            let viewModel = CombinationListViewModel(combinationUseCase: combinationUseCase,
                                                     coordinator: self)
            viewController.viewModel = viewModel
            rootViewController?.pushViewController(viewController, animated: true)
        case .create:
            let viewController = storyboard.instantiate(viewController: CombinationCreateViewController.self)
            viewController.viewModel = CombinationCreateViewModel(combinationUseCase: combinationUseCase,
                                                                  eventUseCase: eventUseCase,
                                                                  coordinator: self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .edit:
            let viewController = storyboard.instantiate(viewController: CombinationEditViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .player:
            let viewcontoller = storyboard.instantiate(viewController: CombinationPlayerViewController.self)
            rootViewController.present(viewcontoller,
                                       animated: true,
                                       completion: nil)
        }
    }
}
