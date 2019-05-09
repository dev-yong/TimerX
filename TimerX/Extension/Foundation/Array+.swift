//
//  Array+.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
extension Array where Element: Equatable {
    mutating func insert(_ newElement: Element, after element: Element) {
        insert(newElement,
               at: (firstIndex { $0 == element } ?? endIndex) + 1)
    }
}
