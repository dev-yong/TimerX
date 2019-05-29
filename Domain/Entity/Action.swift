//
//  Actionable.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

// Abstract Class
public class Action: NSObject {
    public class var identifier: String {
        return "action"
    }
    public let uuid: String
    public let title: String
    public init(uuid: String = UUID().uuidString,
                title: String) {
        self.uuid = uuid
        self.title = title
    }
    public override func isEqual(_ object: Any?) -> Bool {
        guard let action = object as? Action else { return false }
        return action.uuid == uuid &&
            action.title == title
    }
}
