//
//  SwitchTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 01/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class SwitchTableViewCell: TableViewCell {
    public let switchControl = UISwitch()

    override func initialize() {
        super.initialize()
        self.accessoryView = switchControl
    }
}
