//
//  RMEventCombination.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//
import Foundation
import Domain
import RealmSwift

@objcMembers
internal final class RMEventCombination: Object {
    internal dynamic var uuid: String = ""
    internal dynamic var title: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
    internal var events = List<RMAnyEvent>()
}
extension RMEventCombination: DomainConvertible {
    internal func asDomain() -> Domain.EventCombination {
        let eventArray = Array(events.map { $0.value })
            .map { object -> Domain.EventProtocol? in
                if let timeEvent = (object as? RMSimpleEvent)?.asDomain() {
                    return timeEvent
                } else if let countingEvent = (object as? RMCountingEvent)?.asDomain() {
                    return countingEvent
                } else {
                    return nil
                }
            }.compactMap { $0 }
        return Domain.EventCombination(uuid: uuid,
                                       title: title,
                                       events: eventArray)
    }
}
extension Domain.EventCombination: RealmRepresentable {
    func asRealm() -> RMEventCombination {
        let eventList = events.map { event -> RMAnyEvent? in
            if let rmTimeEvent = (event as? SimpleEvent)?.asRealm() {
                return RMAnyEvent(rmTimeEvent)
            } else if let rmCountingEvent = (event as? CountingEvent)?.asRealm() {
                return RMAnyEvent(rmCountingEvent)
            } else {
                return nil
            }
        }.compactMap { $0 }
            .asList()
        return RMEventCombination.build {
            $0.uuid = uuid
            $0.title = title
            $0.events = eventList
        }
    }
}
