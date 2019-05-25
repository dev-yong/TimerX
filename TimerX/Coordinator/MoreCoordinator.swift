//
//  MoreCoordinator.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Coordinator

enum MoreRoute: Route {
    case more
}

class MoreCoordinator: NaivgationCoordinator<MoreRoute> {
    private var storyboard: UIStoryboard {
        return Storyboard.more.instance
    }
    convenience init() {
        self.init(root: .more)
    }
    override func coordinate(_ route: MoreRoute) {
        switch route {
        case .more:
            let viewController = storyboard.instantiate(viewController: MoreViewController.self)
            rootViewController?.pushViewController(viewController, animated: true)
        }
    }
}
