//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

public protocol Route {}
public protocol Coordinator: AnyObject {
    associatedtype RouteType: Route
    
    func go(to route: RouteType)
}
