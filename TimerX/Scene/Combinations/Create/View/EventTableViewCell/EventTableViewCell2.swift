////
////  EventTableViewCell.swift
////  TimerX
////
////  Created by 이광용 on 01/05/2019.
////  Copyright © 2019 GwangYongLee. All rights reserved.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//import RxDataSources
//
//class EventTableViewCell: TableViewCell {
//    @IBOutlet private weak var tableView: DynamicHeightTableView!
//    private var dataSource: RxTableViewSectionedAnimatedDataSource<EventCellSection>?
//    fileprivate let eventSelectionTrigger = PublishSubject<Int>()
//    fileprivate let countSelectionTrigger = PublishSubject<Int>()
//    let tableViewReloadTrigger = PublishSubject<Void>()
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        tableView.register(class: EventTypeTableViewCell.self)
//        tableView.register(class: EventGoalTableViewCell.self)
//        tableView.register(class: EventTimeTableViewCell.self)
//        tableView.register(class: EventTimePickerTableViewCell.self)
//        tableView.register(class: EventCountTableViewCell.self)
//        dataSource = makeDataSource()
//        selectionStyle = .none
//    }
//}
//
//extension EventTableViewCell: CellViewProtocol {
//    func bind(_ cellViewModel: EventCellViewModel) {
//        guard let dataSource = dataSource else { return }
//        let input = EventCellViewModel.Input(rowSelection: tableView.rx.modelSelected(EventCellRow.self).asDriver(),
//                                             eventSelectionTrigger: eventSelectionTrigger.asDriverOnErrorJustComplete(),
//                                             countSelectionTrigger: countSelectionTrigger.asDriverOnErrorJustComplete())
//        let output = cellViewModel.transform(input)
//        [output.sections.drive(tableView.rx.items(dataSource: dataSource)),
//         output.timeRowSelection.drive(tableViewReloadTrigger)].forEach {
//            $0.disposed(by: disposeBag)
//        }
//    }
//    private func makeDataSource() -> RxTableViewSectionedAnimatedDataSource<EventCellSection> {
//        return RxTableViewSectionedAnimatedDataSource<EventCellSection>(
//            animationConfiguration: AnimationConfiguration(insertAnimation: UITableView.RowAnimation.automatic,
//                                                           reloadAnimation: UITableView.RowAnimation.automatic,
//                                                           deleteAnimation: UITableView.RowAnimation.automatic) ,
//            configureCell: { [weak self] (dataSource, tableView, indexPath, _) -> UITableViewCell in
//                guard let self = self else { return UITableViewCell() }
//                switch dataSource[indexPath] {
//                case .eventType(let viewModel):
//                    let cell = tableView.dequeueReusableCell(with: EventTypeTableViewCell.self, for: indexPath)
//                    cell.bind(viewModel)
//                    cell.segmentControl.rx.selectedSegmentIndex.asDriver()
//                        .drive(self.eventSelectionTrigger)
//                        .disposed(by: cell.disposeBag)
//                    return cell
//                case .goal(let viewModel):
//                    let cell = tableView.dequeueReusableCell(with: EventGoalTableViewCell.self, for: indexPath)
//                    cell.bind(viewModel)
//                    return cell
//                case .time(let viewModel):
//                    let cell = tableView.dequeueReusableCell(with: EventTimeTableViewCell.self, for: indexPath)
//                    cell.bind(viewModel)
//                    return cell
//                case .timePicker(let viewModel):
//                    let cell = tableView.dequeueReusableCell(with: EventTimePickerTableViewCell.self, for: indexPath)
//                    cell.bind(viewModel)
//                    return cell
//                case .countType(let viewModel):
//                    let cell = tableView.dequeueReusableCell(with: EventCountTableViewCell.self, for: indexPath)
//                    cell.bind(viewModel)
//                    cell.segmentControl.rx.selectedSegmentIndex.asDriver()
//                        .drive(self.countSelectionTrigger)
//                        .disposed(by: cell.disposeBag)
//                    return cell
//                }
//            })
//    }
//}
