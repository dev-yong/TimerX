//
//  SimpleTimerAction.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public class SimpleTimerAction: TimerActionable {
    public var identifier: TimerXIdentifier {
      return .simpleTimerAction
    }
    public weak var parent: ActionParantable?
    public let uuid: String
    public let title: String
    public let seconds: TimeInterval
    public let countingType: CountingType
    public init(uuid: String = UUID().uuidString,
                title: String = "",
                seconds: TimeInterval = 1.0,
                countingType: CountingType = .up) {
        self.uuid = uuid
        self.title = title
        self.seconds = seconds
        self.countingType = countingType
    }
    private enum CodingKeys: CodingKey {
        case uuid
        case title
        case seconds
        case countingType
    }
}
