//
//  CombinationCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UINavigationController
import Coordinator

internal enum CombinationRoute: Route {
    case combinations
    case create
    case edit
    case player
}

internal final class CombinationCoordinator: NaivgationCoordinator<CombinationRoute> {
    internal override init() {
        super.init()
        coordinate(.combinations)
    }
    internal override func coordinate(_ route: CombinationRoute) {
        switch route {
        case .combinations:
            let viewController1 = Storyboard.combination.instance.instantiate(viewController: ViewController.self)
            rootViewController?.pushViewController(viewController1, animated: false)
        case .create: break
        case .edit: break
        case .player: break
        }
    }
}
