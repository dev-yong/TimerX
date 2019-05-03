//
//  TableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UITableView
import RxSwift

class TableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
