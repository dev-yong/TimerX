//
//  EventTimeTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 03/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventTimeTableViewCell: TableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension EventTimeTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventTimeCellViewModel) {
        guard let textLabel = textLabel else { return }
        guard let detailTextLabel = detailTextLabel else { return }
        cellViewModel.title.drive(textLabel.rx.text)
            .disposed(by: disposeBag)
        cellViewModel.description.drive(detailTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
