//
//  RMTimeEvent.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

internal final class RMTimeEvent {
    internal dynamic var title: String = ""
    internal dynamic var seconds: TimeInterval = 0.0
    internal dynamic var _countingType = CountingType.up.rawValue
    internal var countingType: CountingType {
        get { return CountingType(rawValue: _countingType)! }
        set { _countingType = newValue.rawValue }
    }
    internal var alamrs: [TimeInterval] = []
}
