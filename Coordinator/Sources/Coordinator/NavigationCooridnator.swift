//
//  NavigationCooridnator.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

open class NaivgationCoordinator<RouteType: Route>: BasicCoordinator<UINavigationController, RouteType> {
    public init(root route: RouteType) {
        super.init()
        coordinate(route)
    }
}
