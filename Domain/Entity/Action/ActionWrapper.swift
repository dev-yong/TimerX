//
//  ActionWrapper.swift
//  Domain
//
//  Created by 이광용 on 03/06/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct ActionWrapper: Codable {
    var action: Action
    private enum CodingKeys: CodingKey {
        case identifier
        case parameter
    }
    init(action: Action) {
        self.action = action
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(TimerXIdentifier.self, forKey: .identifier)
        self.action = try identifier.metaType.init(from: container.superDecoder(forKey: .parameter))
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action.identifier, forKey: .identifier)
        try action.encode(to: container.superEncoder(forKey: .parameter))
    }
}
