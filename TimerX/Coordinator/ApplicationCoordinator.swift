//
//  ApplicationCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//
import Foundation
import RealmPlatform
import Coordinator

internal enum ApplicationRoute: Route {
    case homeTab
}
internal final class ApplicationCoordinator: BaseCoordinator<ApplicationRoute> {
    internal var window: UIWindow
    internal init(window: UIWindow) {
        self.window = window
        super.init()
        coordinate(.homeTab)
    }
    internal override func coordinate(_ route: ApplicationRoute) {
        switch route {
        case .homeTab:
            let coordinator = HomeTabCoordinator()
            window.rootViewController = coordinator.rootViewController
        }
    }
}
