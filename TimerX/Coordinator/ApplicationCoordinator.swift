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
internal final class ApplicationCoordinator: Coordinator {
    internal var window: UIWindow
    internal init(window: UIWindow) {
        self.window = window
        go(to: .homeTab)
    }
    internal func go(to route: ApplicationRoute) {
        switch route {
        case .homeTab:
            // todo: Home Tab Coordinator로 변경해줘야함.
            let viewController = Storyboard.main.instance.instantiate(viewController: ViewController.self)
            window.rootViewController = viewController
        }
    }
}
