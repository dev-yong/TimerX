//
//  SegmentTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class SegmentTableViewCell: TableViewCell {
    public let segmentControl = SegmentedControl(items: [])

    override func initialize() {
        super.initialize()
        self.accessoryView = segmentControl
    }
}
