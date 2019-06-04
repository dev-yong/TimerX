//
//  TimerXIdentifier.swift
//  Domain
//
//  Created by 이광용 on 28/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public enum TimerXIdentifier: String, Codable {
    case action = "timerX.action"
    case actionGroup = "timerX.action.group"
    case loopActionGroup = "timerX.action.group.loop"
    case timerAction = "timerX.action.timer"
    case simpleTimerAction = "timerX.action.timer.simple"
    case numberingTimerAction = "timerX.action.timer.numbering"
    public var metaType: Action.Type! {
        switch self {
        case .action:
            return nil
        case .actionGroup:
            return nil
        case .loopActionGroup:
            return LoopActionGroup.self
        case .timerAction:
            return nil
        case .simpleTimerAction:
            return SimpleTimerAction.self
        case .numberingTimerAction:
            return NumberingTimerAction.self
        }
    }
}
