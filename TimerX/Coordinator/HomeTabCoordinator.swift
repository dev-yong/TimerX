//
//  HomeTabCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Domain
import Coordinator

enum HomeTabRoute: Route {
    case combinations
    //    case logs
    case more
}
final class HomeTabCoordinator: TabBarCoordinator<HomeTabRoute> {
    private let useCaseProvider: Domain.UseCaseProvider
    private let combinationCoordinator: RoadMapCoordinator
    private let moreCoordinator: MoreCoordinator
    convenience init(useCaseProvider: Domain.UseCaseProvider) {
        self.init(useCaseProvider: useCaseProvider,
                  combinationCoordinator: RoadMapCoordinator(useCaseProvider: useCaseProvider),
                  moreCoordinator: MoreCoordinator())
    }
    init(useCaseProvider: Domain.UseCaseProvider,
         combinationCoordinator: RoadMapCoordinator,
         moreCoordinator: MoreCoordinator) {
        self.useCaseProvider = useCaseProvider
        self.combinationCoordinator = combinationCoordinator
        self.moreCoordinator = moreCoordinator
        super.init(tabBarItems: [HomeTabBarItem.combinations(self.combinationCoordinator),
                                 HomeTabBarItem.more(self.moreCoordinator)])
    }
    override func coordinate(_ route: HomeTabRoute) {
        switch route {
        case .combinations: select(tab: combinationCoordinator)
        case .more: select(tab: moreCoordinator)
        }
    }
    override func makeRootViewController() -> UITabBarController {
        return Storyboard.home.instance.instantiate(viewController: HomeTabBarViewController.self)
    }
}
extension HomeTabCoordinator {
    fileprivate enum HomeTabBarItem: TabBarItem {
        case combinations(RoadMapCoordinator)
        case more(MoreCoordinator)
        fileprivate var title: String {
            switch self {
            case .combinations: return "Combinations"
            case .more: return "More"
            }
        }
        fileprivate var tabBarItem: UITabBarItem {
            switch self {
            case .combinations: return UITabBarItem(title: title, image: nil, selectedImage: nil)
            case .more: return UITabBarItem(title: title, image: nil, selectedImage: nil)
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
