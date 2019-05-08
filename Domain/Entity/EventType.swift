//
//  EventType.swift
//  Domain
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public enum EventType: Int, CaseIterable {
    case simple, counting
}
extension EventType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .simple: return "Simple"
        case .counting: return "Counting"
        }
    }
}
