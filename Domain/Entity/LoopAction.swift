//
//  LoopAction.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class LoopAction: ActionGroup {
    public override class var identifier: String {
        return [super.identifier, "loop"].joined(separator: ".")
    }
    public override func isEqual(_ object: Any?) -> Bool {
        guard let loopAction = object as? LoopAction else { return false }
        return loopAction.uuid == uuid &&
         loopAction.title == loopAction.title
    }
}
