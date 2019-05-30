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
final class RMActionCombination: Object {
    dynamic var uuid: String = ""
    dynamic var title: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
    var actions = List<RMAnyAction>()
}
extension RMActionCombination: DomainConvertible {
    func asDomain() -> Domain.ActionCombination {
        return Domain.ActionCombination(uuid: uuid,
                                        title: title,
                                        actions: actions.asDomainArray())
    }
}
extension Domain.ActionCombination: RealmRepresentable {
    func asRealm() -> RMActionCombination {
        let eventList = events.map { event -> RMAnyAction? in
            if let rmTimeEvent = (event as? SimpleEvent)?.asRealm() {
                return RMAnyEvent(rmTimeEvent)
            } else if let rmCountingEvent = (event as? CountingEvent)?.asRealm() {
                return RMAnyEvent(rmCountingEvent)
            } else {
                return nil
            }
            }.compactMap { $0 }
            .asList()
        return RMActionCombination.build {
            $0.uuid = uuid
            $0.title = title
            $0.events = eventList
        }
    }
}
