//
//  Time.swift
//  Domain
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public typealias MilliSeconds = Int
public typealias Seconds = Int
public typealias Minutes = Int
public typealias Hours = Int

public struct Time {
    private var _hours: Hours = 0
    private var _minutes: Minutes = 0
    private var _seconds: Seconds = 0
    private var _milliSeconds: MilliSeconds = 0
    public var hours: Hours {
        get { return _hours }
        set {
            assert(newValue < 24)
            _hours = newValue
        }
    }
    public var minutes: Minutes {
        get { return _minutes }
        set {
            assert(newValue < 60)
            _minutes = newValue
        }
    }
    public var seconds: Seconds {
        get { return _seconds }
        set {
            assert(newValue < 60)
            _seconds = newValue
        }
    }
    public var milliSeconds: MilliSeconds {
        get { return _milliSeconds }
        set {
            assert(newValue < 1000)
            _milliSeconds = newValue
        }
    }
    public init(milliSeconds: MilliSeconds,
                seconds: Seconds,
                minutes: Minutes,
                hours: Hours) {
        self.milliSeconds = milliSeconds
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
    }
    public init(timeInterval: TimeInterval) {
        let seconds = Seconds(timeInterval)
        self.init(milliSeconds: MilliSeconds(timeInterval.truncatingRemainder(dividingBy: 1) * 1000),
                  seconds: seconds % 60,
                  minutes: (seconds / 60) % 60,
                  hours: (seconds / (60 * 60)))
    }
    public func asTimeInterval() -> TimeInterval {
        
        return TimeInterval((hours * 60 * 60) + (minutes * 60) + seconds) + TimeInterval(milliSeconds) / 1000
    }
}
extension Time: CustomStringConvertible {
    public var description: String {
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",
                      hours, minutes, seconds, milliSeconds)
    }
}
extension Time: Equatable {
    public static func == (lhs: Time,
                           rhs: Time) -> Bool {
        return lhs.hours == rhs.hours &&
            lhs.minutes == rhs.minutes &&
            lhs.seconds == rhs.seconds &&
            lhs.milliSeconds == rhs.milliSeconds
    }
}
