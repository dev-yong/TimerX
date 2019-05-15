//
//  EventCellViewMdoel.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
protocol EventCellViewMdoelProtocol: ViewModelProtocol
    where Input: EventCellViewModelInputProtocol,
        Output: EventCellViewModelOutputProtocool,
        Input.Row == Output.Section.Item {
    associatedtype Event: NSEvent
    var event: Event { get }
    init(event: Event)
}

protocol EventCellViewModelInputProtocol {
    associatedtype Row
    var rowSelectionTrigger: Driver<Row> { get }
}
protocol EventCellViewModelOutputProtocool {
    associatedtype Section: SectionModelType
    var title: Driver<String> { get }
    var sections: Driver<[Section]> { get }
}
