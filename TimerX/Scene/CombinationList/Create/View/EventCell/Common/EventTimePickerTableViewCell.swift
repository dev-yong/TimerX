//
//  EventTimePickerTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

class EventTimePickerTableViewCell: TimerPickerTableViewCell {
}

extension EventTimePickerTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventTimePickerCellViewModel) {
        cellViewModel.timeInterval
        .drive(onNext: { [weak self] in
            self?.timerPickerView.countDownDuration = $0
        }).disposed(by: disposeBag)
    }
}
