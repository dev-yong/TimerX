//
//  HomeTabCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Coordinator

internal enum HomeTabRoute: Route {
    case combinations
//    case logs
    case more
}
internal final class HomeTabCoordinator: TabBarCoordinator<HomeTabRoute> {
    private let combinationCoordinator: CombinationCoordinator
    private let moreCoordinator: MoreCoordinator

    internal init(combinationCoordinator: CombinationCoordinator = CombinationCoordinator(),
                  moreCoordinator: MoreCoordinator = MoreCoordinator()) {
        self.combinationCoordinator = combinationCoordinator
        self.moreCoordinator = moreCoordinator
        super.init(tabBarItems: [HomeTabBarItem.combinations(self.combinationCoordinator),
                                 HomeTabBarItem.more(self.moreCoordinator)])
    }
    internal override func coordinate(_ route: HomeTabRoute) {
        switch route {
        case .combinations: select(tab: combinationCoordinator)
        case .more: select(tab: moreCoordinator)
        }
    }
    internal override func makeRootViewController() -> UITabBarController {
        return Storyboard.home.instance.instantiate(viewController: HomeTabBarViewController.self)
    }
}
extension HomeTabCoordinator {
    fileprivate enum HomeTabBarItem: TabBarItem {
        case combinations(CombinationCoordinator)
        case more(MoreCoordinator)
        fileprivate var title: String {
            switch self {
            case .combinations: return "Combinations"
            case .more: return "More"
            }
        }
        fileprivate var viewController: UIViewController? {
            switch self {
            case .combinations(let coordinator): return makeViewController(of: coordinator)
            case .more(let coordinator): return makeViewController(of: coordinator)
            }
        }
    }
}
