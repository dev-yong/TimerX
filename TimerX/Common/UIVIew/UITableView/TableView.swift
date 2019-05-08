//
//  TableView.swift
//  TimerX
//
//  Created by 이광용 on 04/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UITableView

class TableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialze()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialze()
    }
    func initialze() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 54
        separatorStyle = .none
    }
}
