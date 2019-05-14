//
//  EventCountTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EventCountTableViewCell: SegmentTableViewCell {
}

extension EventCountTableViewCell {
    func bind(_ cellViewModel: EventCountTypeCellViewModel) {
        guard let textLabel = textLabel else { return }
        // todo: two-way binding
        [cellViewModel.title.drive(textLabel.rx.text),
         cellViewModel.countingSegemnts.drive(segmentControl.rx.items),
         cellViewModel.selectedCountType.drive(segmentControl.rx.selectedSegmentIndex)].forEach {
            $0.disposed(by: disposeBag)
        }
    }
}
