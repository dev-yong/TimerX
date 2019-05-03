//
//  TimePickerTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class TimePickerTableViewCell: TableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    public lazy var timePickerView: TimePickerView = {
        let pickerView = TimePickerView()
        return pickerView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    private func initialize() {
        addSubview(containerView)
        containerView.addSubview(timePickerView)
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        containerView.addConstraints([NSLayoutConstraint(item: self,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: containerView,
                                                         attribute: .top,
                                                         multiplier: 1.0,
                                                         constant: 0.0)])
    }
}
