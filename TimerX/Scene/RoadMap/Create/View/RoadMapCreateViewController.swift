//
//  CombinationCreateViewController.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RoadMapCreateViewController: UIViewController, CellHeightCachable {
    fileprivate let addSimpleEventBarButtonitem = UIBarButtonItem(title: "Simple",
                                                                  style: .plain,
                                                                  target: nil,
                                                                  action: nil)
    fileprivate let addCountingEventBarButtonitem = UIBarButtonItem(title: "Counting",
                                                                    style: .plain,
                                                                    target: nil,
                                                                    action: nil)
    fileprivate let saveBarButtonitem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    @IBOutlet fileprivate weak var eventTableView: TableView!
    var viewModel: RoadMapCreateViewModel!
    var cellHeightsDictionary = [String: CGFloat]()
    fileprivate var disposeBag = DisposeBag()
    fileprivate var dataSource: RxTableViewSectionedAnimatedDataSource<RoadMapSection>?
    private let deleteEventTrigger = PublishSubject<RoadMapRow>()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItems([addSimpleEventBarButtonitem,
                                               addCountingEventBarButtonitem,
                                               saveBarButtonitem],
                                              animated: true)
        eventTableView.register(class: SimpleTimerTableVeiwCell.self)
        eventTableView.register(class: NumberingTimerTableVeiwCell.self)
        eventTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        bind(viewModel)
    }
}
extension RoadMapCreateViewController: ViewProtocol {
    func bind(_ viewModel: RoadMapCreateViewModel) {
        dataSource = makeDataSource()
        guard let dataSource = self.dataSource else { return }
        let input = RoadMapCreateViewModel.Input(addSimpleTimerTrigger: addSimpleEventBarButtonitem.rx.tap.asDriver(),
                                                     addNumberingTimerTrigger: addCountingEventBarButtonitem.rx.tap.asDriver(),
                                                     deleteActionTrigger: deleteEventTrigger.asDriverOnErrorJustNever(),
                                                     saveRoadMapTrigger: saveBarButtonitem.rx.tap.asDriver())
        let output = viewModel.transform(input)
        [output.sections.drive(eventTableView.rx.items(dataSource: dataSource)),
         output.addSimpleEvent.drive(),
         output.addCountingEvent.drive(),
         output.deleteEvent.drive(),
         output.saveCombination.drive()].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedAnimatedDataSource<RoadMapSection> {
        return RxTableViewSectionedAnimatedDataSource<RoadMapSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .fade) ,
            configureCell: { [weak self] (dataSource, tableView, indexPath, row) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                switch dataSource[indexPath] {
                case .loop:
                    return TableViewCell()
                case .simpleTimer(let viewModel):
                    let cell = tableView.dequeueReusableCell(with: SimpleTimerTableVeiwCell.self, for: indexPath)
                    cell.bind(viewModel)
                    cell.closeButton.rx.tap.map { _ in row }
                        .bind(to: self.deleteEventTrigger)
                        .disposed(by: cell.disposeBag)
                    return cell
                case .numberingTimer(let viewModel):
                    let cell = tableView.dequeueReusableCell(with: NumberingTimerTableVeiwCell.self, for: indexPath)
                    cell.bind(viewModel)
                    cell.closeButton.rx.tap.map { _ in row }
                        .bind(to: self.deleteEventTrigger)
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            })
    }
}
extension RoadMapCreateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightsDictionary[indexPath.cacheKey] = cell.frame.size.height
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.3
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightsDictionary[indexPath.cacheKey] ?? UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // todo
        guard let dataSource = self.dataSource else { return 0.0 }
        let inset = Configuration.Dimension.inset * 2
        let titleHeight = Configuration.Dimension.TableView.titleHeight
        let rowHeight = Configuration.Dimension.TableView.rowHeight
        switch dataSource[indexPath] {
        case .loop: return 0
        case .simpleTimer: return inset + titleHeight + rowHeight * 2
        case .numberingTimer: return inset + titleHeight + rowHeight * 3
        }
    }
}
