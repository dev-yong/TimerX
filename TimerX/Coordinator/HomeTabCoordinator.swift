//
//  HomeTabCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UITabBarController
import Coordinator

internal enum HomeTabRoute: Route {
    case combinations
//    case logs
//    case more
}

internal final class HomeTabCoordinator: TabBarCoordinator<HomeTabRoute> {
    private let combinationCoordinator: CombinationCoordinator

    internal init(combinationCoordinator: CombinationCoordinator = CombinationCoordinator()) {
        self.combinationCoordinator = combinationCoordinator
        super.init()
        rootViewController?.setViewControllers([combinationCoordinator.rootViewController], animated: true)
    }
    internal override func coordinate(_ route: HomeTabRoute) {
        switch route {
        case .combinations: select(tab: combinationCoordinator)
        }
    }
    internal override func makeRootViewController() -> UITabBarController {
        return Storyboard.home.instance.instantiate(viewController: HomeTabBarViewController.self)
    }
}
