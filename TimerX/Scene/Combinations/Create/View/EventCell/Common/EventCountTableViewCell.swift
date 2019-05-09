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

extension EventCountTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventCountTypeCellViewModel) {
        guard let textLabel = textLabel else { return }
        cellViewModel.title.drive(textLabel.rx.text)
            .disposed(by: disposeBag)
        cellViewModel.countSegments.drive(segmentControl.rx.items)
            .disposed(by: disposeBag)
        cellViewModel.selectedCountingType.drive(segmentControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
    }
}
