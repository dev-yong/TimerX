//
//  EventTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 01/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet private weak var tableView: UITableView!
    
    
}

extension EventTableViewCell: CellViewProtocol {
    func bind(_ cellViewModel: EventCellViewModel) {
        
    }
}
