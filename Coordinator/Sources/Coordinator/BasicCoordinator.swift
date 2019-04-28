//
//  BasicCoordinator.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

open class BasicCoordinator<RootViewController: UIViewController, RouteType: Route>: BaseCoordinator<RouteType>, RootableCoordinatorProtocol {
    public private (set) var rootViewController: RootViewController!
    public override init() {
        super.init()
        self.rootViewController = makeRootViewController()
    }
    open func makeRootViewController() -> RootViewController {
        return RootViewController()
    }
}
