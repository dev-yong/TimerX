//
//  Time.swift
//  Domain
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct Time {
    private var _hour: Int = 0
    private var _minute: Int = 0
    private var _second: Int = 0
    var hour: Int {
        get { return _hour }
        set {
            assert(newValue < 24)
            _hour = newValue
        }
    }
    var minute: Int {
        get { return _minute }
        set {
            assert(newValue < 60)
            _minute = newValue
        }
    }
    var second: Int {
        get { return _second }
        set {
            assert(newValue < 60)
            _second = newValue
        }
    }
    init(hour: Int = 0,
         minute: Int = 0,
         second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    init(second: TimeInterval) {
        let interval = Int(second)
        self.second = interval % 60
        minute = (interval / 60) % 60
        hour = (interval / 3600)
    }
}

extension Time: CustomStringConvertible {
    var description: String {
        return String(format: "%0.2d:%0.2d:%0.2d",
                      hour, minute, second)
    }
}
