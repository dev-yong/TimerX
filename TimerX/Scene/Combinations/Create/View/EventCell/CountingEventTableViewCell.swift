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
    private var dataSource: RxTableViewSectionedAnimatedDataSource<CountingEventSection>?
    fileprivate let countSelectionTrigger = PublishSubject<Int>()
    override func initialize() {
        super.initialize()
        tableView.register(class: EventTimeTableViewCell.self)
        tableView.register(class: EventTimePickerTableViewCell.self)
        tableView.register(class: EventCountTableViewCell.self)
        dataSource = makeDataSource()
        selectionStyle = .none
    }
}
extension CountingEventTableVeiwCell: CellViewProtocol {
    func bind(_ cellViewModel: CountingEventCellViewModel) {
        guard let dataSource = dataSource else { return }
        let input = CountingEventCellViewModel.Input(rowSelection: tableView.rx.modelSelected(CountingEventRow.self).asDriver(),
                                                     countSelectionTrigger: countSelectionTrigger.asDriverOnErrorJustComplete())
        let output = cellViewModel.transform(input)
        [output.title.drive(titleLabel.rx.text),
         output.timeRowSelection.drive(),
         output.sections.drive(tableView.rx.items(dataSource: dataSource))].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedAnimatedDataSource<CountingEventSection> {
        return RxTableViewSectionedAnimatedDataSource<CountingEventSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .fade) ,
            configureCell: { [weak self] (dataSource, tableView, indexPath, _) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                switch dataSource[indexPath] {
                case .goal(let _):
                    return UITableViewCell()
                case .time(let viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventTimeTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case .timePicker(let viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventTimePickerTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case .countType(let viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventCountTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    cell.segmentControl.rx.selectedSegmentIndex.asDriver()
                        .drive(self.countSelectionTrigger)
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            })
    }
}
