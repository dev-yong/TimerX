//
//  AppDelegate.swift
//  TimerX
//
//  Created by 이광용 on 20/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: ApplicationCoordinator!
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let window = window {
            coordinator = ApplicationCoordinator(window: window)
        }
        return true
    }
}
