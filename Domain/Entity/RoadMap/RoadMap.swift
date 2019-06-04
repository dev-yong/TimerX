//
//  ActionCombination.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class RoadMap: RoadMapComponentable, ActionParantable {
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
    private enum CodingKeys: CodingKey {
        case uuid
        case title
        case actions
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(String.self, forKey: .uuid)
        title = try container.decode(String.self, forKey: .title)
        let actionWrappers = try container.decode([ActionWrapper].self, forKey: .actions)
        actions = actionWrappers.map { $0.action }
    }
}
