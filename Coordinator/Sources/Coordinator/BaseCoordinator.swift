//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
open class BaseCoordinator<RouteType: Route>: CoordinatorProtocol {
    public init() {}
    open func coordinate(_ route: RouteType) {}
}
