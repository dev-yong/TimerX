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
    case combination, timeLog
    internal var name: String {
        switch self {
        case .combination: return "Combination"
        case .timeLog: return "TimeLog"
        }
    }
    internal var bundle: Bundle? {
        return nil
    }
}
