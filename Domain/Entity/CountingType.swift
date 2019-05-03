//
//  CountingType.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public enum CountingType: Int, CaseIterable {
    case up, down
}

extension CountingType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .up: return "Up"
        case .down: return "Down"
        }
    }
}
