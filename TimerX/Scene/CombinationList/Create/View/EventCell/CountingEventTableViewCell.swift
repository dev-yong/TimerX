//
//  CountingEventTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 07/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CountingEventTableVeiwCell: EventTableViewCell {
    private var dataSource: RxTableViewSectionedReloadDataSource<CountingEventSection>?
    fileprivate let timeIntervalSelectionTrigger = PublishSubject<TimeInterval>()
    fileprivate let countSegmentSelectionTrigger = PublishSubject<Int>()
    override func initialize() {
        super.initialize()
        tableView.register(class: EventGoalTableViewCell.self)
        tableView.register(class: EventTimeTableViewCell.self)
        tableView.register(class: EventCountTableViewCell.self)
        dataSource = makeDataSource()
    }
}
extension CountingEventTableVeiwCell: CellViewProtocol {
    func bind(_ cellViewModel: CountingEventCellViewModel) {
        guard let dataSource = dataSource else { return }
        let rowSelectionTrigger = tableView.rx.modelSelected(CountingEventRow.self).asDriver()
        let countSegmentSelectionTrigger = self.countSegmentSelectionTrigger.asDriverOnErrorJustComplete()
        let input = CountingEventCellViewModel.Input(rowSelectionTrigger: rowSelectionTrigger,
                                                     countSegmentSelectionTrigger: countSegmentSelectionTrigger)
        let output = cellViewModel.transform(input)
        [output.title.drive(titleLabel.rx.text),
         output.sections.drive(tableView.rx.items(dataSource: dataSource)),
         output.countSegmentSelection.drive()].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedReloadDataSource<CountingEventSection> {
        return RxTableViewSectionedReloadDataSource<CountingEventSection>(
            configureCell: { [weak self] (dataSource, tableView, indexPath, _) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                switch dataSource[indexPath] {
                case let .goal(viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventGoalTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case let .time(viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventTimeTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case let .countType(viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventCountTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    cell.segmentControl.rx.selectedSegmentIndex.asDriver()
                        .drive(self.countSegmentSelectionTrigger)
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            })
    }
}
