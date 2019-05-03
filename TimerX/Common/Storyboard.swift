//
//  Storyboard.swift
//  TimerX
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Coordinator

internal enum Storyboard: StoryboardProtocol {
    case home, combination, timeLog, more
    internal var name: String {
        switch self {
        case .home: return "Home"
        case .combination: return "Combination"
        case .timeLog: return "TimeLog"
        case .more: return "More"
        }
    }
    internal var bundle: Bundle? {
        return nil
    }
}
