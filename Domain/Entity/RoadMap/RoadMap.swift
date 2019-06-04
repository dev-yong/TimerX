//
//  ActionCombination.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class RoadMap: RoadMapComponent, ActionOwner {
    public let uuid: String
    public let title: String
    public let actions: [Action]
    public init(uuid: String = UUID().uuidString,
                title: String,
                actions: [Action]) {
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
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(title, forKey: .title)
        try container.encode(actions.map { ActionWrapper(action: $0) }, forKey: .actions)
    }
}
