//
//  TimeUnitCell.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
class TimeUnitCell: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let timeUnit: TimeUnit
    init(timeUnit: TimeUnit) {
        self.timeUnit = timeUnit
        super.init(frame: .zero)
        initialize()
    }
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initialize() {
        titleLabel.text = timeUnit.description
        switch timeUnit {
        case .hour, .minute, .second:
            titleLabel.textAlignment = .left
        case .milliSecond:
            titleLabel.textAlignment = .right
        }
        addSubview(titleLabel)
        updateConstraintsIfNeeded()
    }
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        self.snp.makeConstraints {
            $0.width.equalTo(75)
            $0.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.bottom.equalToSuperview()
            switch self.timeUnit {
            case .hour, .minute, .second:
                $0.width.equalTo(40)
                $0.trailing.equalToSuperview()
            case .milliSecond:
                $0.width.equalTo(30)
                $0.leading.equalToSuperview()
            }
        }
    }
}
