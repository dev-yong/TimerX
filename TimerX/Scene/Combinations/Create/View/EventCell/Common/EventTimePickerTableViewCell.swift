//
//  EventTimePickerTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

class EventTimePickerTableViewCell: TimePickerTableViewCell {
}

extension EventTimePickerTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventTimePickerCellViewModel) {
//        cellViewModel.time.asDriver().drive(onNext: { [weak self] in
//            self?.timePickerView.set(hour: $0.hour,
//                                    minute: $0.minute,
//                                    second: $0.second, animated: true)
//        }).disposed(by: disposeBag)
    }
}
