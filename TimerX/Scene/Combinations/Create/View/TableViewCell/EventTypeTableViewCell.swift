//
//  EventTypeTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

class EventTypeTableViewCell: SegmentTableViewCell {
    override func initialize() {
        super.initialize()
        // ViewModel에서 Segment Model을 바인딩.
        // SelectedIndex도 바인딩한다.
    }
}

extension EventTypeTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventTypeCellViewModel) {
        cellViewModel.eventSegments
            .drive(segmentControl.rx.items)
            .disposed(by: disposeBag)
    }
}
