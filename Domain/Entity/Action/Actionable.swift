//
//  Actionable.swift
//  Domain
//
//  Created by 이광용 on 28/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol Actionable: RoadMapComponentable {
    var title: String { get }
    var uuid: String { get }
}
