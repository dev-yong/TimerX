//
//  TimeUnit.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
enum TimeUnit: CustomStringConvertible {
    case hour, minute, second, milliSecond
    var description: String {
        switch self {
        case .hour: return "hours"
        case .minute: return "min"
        case .second: return "sec"
        case .milliSecond: return "."
        }
    }
}
