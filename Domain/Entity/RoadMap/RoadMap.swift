//
//  ActionCombination.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct RoadMap: RoadMapComponentable {
    public let uuid: String
    public let title: String
    public let actions: [Actionable]
    public init(uuid: String = UUID().uuidString,
                title: String,
                actions: [Actionable]) {
        self.uuid = uuid
        self.title = title
        self.actions = actions
    }
}
