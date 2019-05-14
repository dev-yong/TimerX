//
//  TimePickerTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class TimerPickerTableViewCell: TableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    public lazy var timerPickerView: TimerPickerView = {
        let pickerView = TimerPickerView()
        return pickerView
    }()
    override func initialize() {
        super.initialize()
        contentView.addSubview(containerView)
        containerView.addSubview(timerPickerView)
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.height.equalTo(150).priority(999)
        }
        timerPickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
