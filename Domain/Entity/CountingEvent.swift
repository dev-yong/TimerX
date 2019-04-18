//
//  CountingEvent.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct CountingEvent: EventProtocol {
    public let title: String
    public let interval: TimeInterval
    public let countingType: CountingType
    public let goal: Int
}
