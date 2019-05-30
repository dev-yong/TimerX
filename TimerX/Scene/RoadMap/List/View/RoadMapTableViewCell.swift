//
//  CombinationTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 22/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class RoadMapTableViewCell: TableViewCell, CellViewProtocol {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    func bind(_ cellViewModel: RoadMapCellViewModel) {
        guard let textLabel = self.textLabel,
            let detailTextLabel = self.detailTextLabel else { return }
        detailTextLabel.numberOfLines = 0
        cellViewModel.title.drive(textLabel.rx.text)
            .disposed(by: disposeBag)
        cellViewModel.description.drive(detailTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
