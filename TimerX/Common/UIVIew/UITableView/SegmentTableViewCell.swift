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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    private func initialize() {
        self.accessoryView = segmentControl
    }
}
