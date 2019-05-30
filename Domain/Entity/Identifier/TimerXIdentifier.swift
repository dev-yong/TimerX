//
//  TimerXIdentifier.swift
//  Domain
//
//  Created by 이광용 on 28/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public enum TimerXIdentifier {
    case roadMap
    case action
    case actionGroup
    case loopActionGroup
    case timerAction
    case simpleTimerAction
    case numberingTimerAction
    init?(identifier: String) {
        switch identifier {
        case TimerXIdentifier.roadMap.identifier:
            self = .roadMap
        case TimerXIdentifier.action.identifier:
            self = .action
        case TimerXIdentifier.actionGroup.identifier:
            self = .actionGroup
        case TimerXIdentifier.loopActionGroup.identifier:
            self = .loopActionGroup
        case TimerXIdentifier.timerAction.identifier:
            self = .timerAction
        case TimerXIdentifier.simpleTimerAction.identifier:
            self = .simpleTimerAction
        case TimerXIdentifier.numberingTimerAction.identifier:
            self = .numberingTimerAction
        default:
            return nil
        }
    }
    private var baseIdentifier: String {
        return "timerX"
    }
    private var subIdentifier: String {
        switch self {
        case .roadMap:
            return "roadMap"
        case .action:
            return "action"
        case .actionGroup:
            return [TimerXIdentifier.action.subIdentifier, "group"].joined(separator: ".")
        case .loopActionGroup:
            return [TimerXIdentifier.actionGroup.subIdentifier, "loop"].joined(separator: ".")
        case .timerAction:
            return [TimerXIdentifier.action.subIdentifier, "timer"].joined(separator: ".")
        case .simpleTimerAction:
            return [TimerXIdentifier.timerAction.subIdentifier, "simple"].joined(separator: ".")
        case .numberingTimerAction:
            return [TimerXIdentifier.timerAction.subIdentifier, "numbering"].joined(separator: ".")
        }
    }
    public var identifier: String {
        return [baseIdentifier, subIdentifier].joined(separator: ".")
    }
    public var type: RoadMapComponentable.Type? {
        switch self {
        case .roadMap:
            return RoadMap.self
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
