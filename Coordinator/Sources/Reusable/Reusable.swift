//
//  Reusable.swift
//  TimerX
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol Reusable: AnyObject { }
extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
