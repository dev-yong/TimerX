//
//  EventCellViewMdoel.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import RxDataSources

protocol ActionCellViewMdoelProtocol: ViewModelProtocol
    where Input: ActionCellViewModelInputProtocol,
        Output: ActionCellViewModelOutputProtocool,
        Input.Row == Output.Section.Item {
    associatedtype Action: Actionable
    var action: Action { get }
    init(action: Action)
}

protocol ActionCellViewModelInputProtocol {
    associatedtype Row
    var rowSelectionTrigger: Driver<Row> { get }
}
protocol ActionCellViewModelOutputProtocool {
    associatedtype Section: SectionModelType
    var title: Driver<String> { get }
    var sections: Driver<[Section]> { get }
}
