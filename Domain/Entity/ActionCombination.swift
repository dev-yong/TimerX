//
//  ActionCombination.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct ActionCombination {
    public static var identifier: String {
        return "combination"
    }
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
}

extension ActionCombination: Equatable {
    public static func == (lhs: ActionCombination,
                           rhs: ActionCombination) -> Bool {
        return lhs.uuid == rhs.uuid &&
            lhs.title == rhs.title &&
            lhs.actions == rhs.actions
    }
}
