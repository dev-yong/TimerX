//
//  TabBarCoordiantor.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

open class TabBarCoordinator<RouteType: Route>: BasicCoordinator<UITabBarController, RouteType> {
    public func select<Coordiator>(tab coordinator: Coordiator) where Coordiator: RootableCoordinatorProtocol {
        rootViewController?.selectedViewController = coordinator.rootViewController
    }
    public func select(tab viewController: UIViewController?) {
        rootViewController?.selectedViewController = viewController
    }
}
