//
//  DomainConvertible.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
internal protocol DomainConvertible {
    associatedtype DomainObject
    func asDomain() -> DomainObject
}
