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

internal final class ApplicationCoordinator: Coordinator {
    internal var window: UIWindow
    private let realmUseCase
    internal init(window: UIWindow) {
        self.window = window
    }
    internal func start() {
        window.rootViewController = Storyboard.combination.instance.instantiate(viewController: ViewController.self)
        window.makeKeyAndVisible()
    }
}
