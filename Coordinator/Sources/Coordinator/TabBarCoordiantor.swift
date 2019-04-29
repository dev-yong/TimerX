//
//  TabBarCoordiantor.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

public protocol TabBarItem {
    var tabBarItem: UITabBarItem { get }
    var viewController: UIViewController? { get }
}
extension TabBarItem {
    public func makeViewController<Coordinator: RootableCoordinatorProtocol>(of coordinator: Coordinator) -> UIViewController? {
        let viewController = coordinator.rootViewController
        viewController?.tabBarItem = tabBarItem
        return viewController
    }
}

open class TabBarCoordinator<RouteType: Route>: BasicCoordinator<UITabBarController, RouteType> {
    public init(tabBarItems: [TabBarItem]) {
        super.init()
        rootViewController.setViewControllers(tabBarItems.map { $0.viewController }.compactMap { $0 },
                                              animated: false)
    }
    public init(viewControllers: [UIViewController]?) {
        super.init()
        rootViewController.setViewControllers(viewControllers, animated: false)
    }
    public func select<Coordiator>(tab coordinator: Coordiator) where Coordiator: RootableCoordinatorProtocol {
        select(tab: coordinator.rootViewController)
    }
    public func select(tab viewController: UIViewController?) {
        rootViewController?.selectedViewController = viewController
    }
}
