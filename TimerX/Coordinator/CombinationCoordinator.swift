//
//  CombinationCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Coordinator

internal enum CombinationRoute: Route {
    case combinations
    case create
    case edit
    case player
}

internal final class CombinationCoordinator: NaivgationCoordinator<CombinationRoute> {
    private var storyboard: UIStoryboard {
        return Storyboard.combination.instance
    }
    internal convenience init() {
        self.init(root: .combinations)
    }
    internal override func coordinate(_ route: CombinationRoute) {
        switch route {
        case .combinations:
            let viewController = storyboard.instantiate(viewController: CombinationsViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .create:
            let viewController = storyboard.instantiate(viewController: CombinationCreateViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .edit:
            let viewController = storyboard.instantiate(viewController: CombinationEditViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        case .player:
            let viewcontoller = storyboard.instantiate(viewController: CombinationPlayerViewController.self)
            rootViewController.present(viewcontoller,
                                       animated: true,
                                       completion: nil)
        }
    }
}
