//
//  TimeValueCell.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
class TimeValueCell: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .right
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
        addSubview(titleLabel)
        updateConstraintsIfNeeded()
    }
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        self.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(70)
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.bottom.equalToSuperview()
            switch self.timeUnit {
            case .hour, .minute, .second:
                $0.width.equalTo(30)
                $0.leading.equalToSuperview()
            case .milliSecond:
                $0.width.equalTo(40)
                $0.trailing.equalToSuperview()
            }
        }
    }
}
