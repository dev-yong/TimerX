//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol Route {}
public protocol CoordinatorProtocol: AnyObject {
    associatedtype RouteType: Route
    func coordinate(_ route: RouteType)
}

public protocol RootableCoordinatorProtocol: CoordinatorProtocol {
    associatedtype RootViewController: UIViewController
    var rootViewController: RootViewController! { get }
    func makeRootViewController() -> RootViewController
}
