//
//  SwitchTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 01/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    public let switchControl = UISwitch()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    private func initialize() {
        switchControl.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.accessoryView = switchControl
    }
}
