//
//  SimpleEventTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SimpleEventTableVeiwCell: EventTableViewCell {
    private var dataSource: RxTableViewSectionedAnimatedDataSource<SimpleEventSection>?
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
extension SimpleEventTableVeiwCell: CellViewProtocol {
    func bind(_ cellViewModel: SimpleEventCellViewModel) {
        guard let dataSource = dataSource else { return }
        let input = SimpleEventCellViewModel.Input(rowSelection: tableView.rx.modelSelected(SimpleEventRow.self).asDriver(),
                                       countSelectionTrigger: countSelectionTrigger.asDriverOnErrorJustComplete())
        let output = cellViewModel.transform(input)
        [output.title.drive(titleLabel.rx.text),
         output.timeRowSelection.drive(),
         output.sections.drive(tableView.rx.items(dataSource: dataSource))].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedAnimatedDataSource<SimpleEventSection> {
        return RxTableViewSectionedAnimatedDataSource<SimpleEventSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .fade) ,
            configureCell: { [weak self] (dataSource, tableView, indexPath, _) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                switch dataSource[indexPath] {
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
