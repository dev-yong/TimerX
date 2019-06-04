//
//  ActionWrapper.swift
//  Domain
//
//  Created by 이광용 on 03/06/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct ActionWrapper: Decodable {
    var action: Actionable
    private enum CodingKeys: CodingKey {
        case identifier
        case parameter
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(TimerXIdentifier.self, forKey: .identifier)
        self.action = try identifier.metaType.init(from: container.superDecoder(forKey: .parameter))
    }
}
