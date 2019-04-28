//
//  AppDelegate.swift
//  TimerX
//
//  Created by 이광용 on 20/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

@UIApplicationMain
internal class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?
    private var coordinator: ApplicationCoordinator!

    internal func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            coordinator = ApplicationCoordinator(window: window)
        }
        return true
    }
}
