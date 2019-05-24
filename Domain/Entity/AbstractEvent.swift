//
//  EventProtocol.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class AbstractEvent: NSObject {
    public let uuid: String
    public init(uuid: String) {
        self.uuid = uuid
    }
}
