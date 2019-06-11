//
//  Actionable.swift
//  Domain
//
//  Created by 이광용 on 28/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol ActionOwner: RoadMapComponent, AnyObject {
    var actions: [Action] { get }
}

public protocol Action: RoadMapComponent, AnyObject {
    var identifier: TimerXIdentifier { get }
    var owner: ActionOwner? { get set }
    var uuid: String { get }
    var title: String { get }
}
