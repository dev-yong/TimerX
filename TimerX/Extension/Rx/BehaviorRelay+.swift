//
//  BehaviorRelay+.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxCocoa

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }
    func append(contentsOf subelements: Element) {
        var newValue = value
        newValue.append(contentsOf: subelements)
        accept(newValue)
    }
    func insert(_ subElement: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(subElement, at: index)
        accept(newValue)
    }
    func insert(contentsOf subelements: Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(contentsOf: subelements, at: index)
        accept(newValue)
    }
    func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
}

public extension BehaviorRelay where Element: RangeReplaceableCollection, Element.Element: Equatable {
    func remove(_ element: Element.Element) {
        var newValue = value
        newValue.removeAll { $0 == element }
        accept(newValue)
    }
}
