//
//  ActionGroup.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class ActionGroup: Action {
    public override class var identifier: String {
        return [super.identifier, "group"].joined(separator: ".")
    }
    public let actions: [Action]
    public init(uuid: String = UUID().uuidString,
                title: String,
                actions: [Action]) {
        self.actions = actions
        super.init(uuid: uuid, title: title)
    }
    public override func isEqual(_ object: Any?) -> Bool {
        guard let actionGroup = object as? ActionGroup else { return false }
        return actionGroup.uuid == uuid &&
            actionGroup.title == title &&
            actionGroup.actions == actions
    }
}
