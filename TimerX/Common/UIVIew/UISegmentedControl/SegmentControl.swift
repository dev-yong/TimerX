//
//  SegmentControl.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UISegmentedControl
class SegmentedControl: UISegmentedControl {
    func set(items: [String?], animated: Bool) {
        removeAllSegments()
        items.enumerated().forEach {
            insertSegment(withTitle: $0.element, at: $0.offset, animated: animated)
        }
    }
}
