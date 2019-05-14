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

internal class CombinationCreateViewController: UIViewController, CellHeightCachable {
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
    var viewModel: CombinationCreateViewModel!
    var cellHeightsDictionary = [String: CGFloat]()
    fileprivate var disposeBag = DisposeBag()
    fileprivate var dataSource: RxTableViewSectionedAnimatedDataSource<CombinationSection>?
    override internal func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItems([addSimpleEventBarButtonitem,
                                               addCountingEventBarButtonitem,
                                               saveBarButtonitem],
                                              animated: true)
        eventTableView.register(class: SimpleEventTableVeiwCell.self)
        eventTableView.register(class: CountingEventTableVeiwCell.self)
        eventTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        bind(viewModel)
    }
}
extension CombinationCreateViewController: ViewProtocol {
    internal func bind(_ viewModel: CombinationCreateViewModel) {
        dataSource = makeDataSource()
        guard let dataSource = self.dataSource else { return }
        let input = CombinationCreateViewModel.Input(addSimpleEventTrigger: addSimpleEventBarButtonitem.rx.tap.asDriver(),
                                                     addCountingEventTrigger: addCountingEventBarButtonitem.rx.tap.asDriver(),
                                                     saveCombinationTrigger: saveBarButtonitem.rx.tap.asDriver())
        let output = viewModel.transform(input)
        [output.sections.drive(eventTableView.rx.items(dataSource: dataSource)),
         output.addSimpleEvent.drive(),
         output.addCountingEvent.drive()].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedAnimatedDataSource<CombinationSection> {
        return RxTableViewSectionedAnimatedDataSource<CombinationSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .automatic,
                                                           reloadAnimation: .automatic,
                                                           deleteAnimation: .automatic) ,
            configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
                switch dataSource[indexPath] {
                case let .simple(_, viewModel):
                    let cell = tableView.dequeueReusableCell(with: SimpleEventTableVeiwCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case let .counting(_, viewModel):
                    let cell = tableView.dequeueReusableCell(with: CountingEventTableVeiwCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                }
            })
    }
}
extension CombinationCreateViewController: UITableViewDelegate {
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
        guard let row = dataSource?[indexPath] else { return 0.0 }
        switch row {
        case .simple: return 44 * 3 + 170 + 20
        case .counting: return 44 * 4 + 170 + 20
        }
    }
}
