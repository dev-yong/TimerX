//
//  CombinationListViewController.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Designable
import RxSwift
import RxCocoa
import RxDataSources

class CombinationListViewController: UIViewController {
    @IBOutlet private weak var combinationTableView: TableView!
    @IBOutlet private weak var createButton: DesignableButton!
    private let disposeBag = DisposeBag()
    var viewModel: CombinationListViewModel!
    private var dataSource: RxTableViewSectionedReloadDataSource<CombinationListSection>?
    override func viewDidLoad() {
        super.viewDidLoad()
        combinationTableView.register(class: CombinationTableViewCell.self)
        bind(viewModel)
    }
}
extension CombinationListViewController: ViewProtocol {
    func bind(_ viewModel: CombinationListViewModel) {
        dataSource = makeDataSource()
        guard let dataSource = self.dataSource else { return }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = CombinationListViewModel.Input(trigger: viewWillAppear,
                                                   createCombiationTrigger: createButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        [output.createCombination.drive(),
         output.combinationListSections.drive(combinationTableView.rx.items(dataSource: dataSource))].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedReloadDataSource<CombinationListSection> {
        return RxTableViewSectionedReloadDataSource<CombinationListSection>(
            configureCell: { (_, tableView, indexPath, row) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(with: CombinationTableViewCell.self,
                                                         for: indexPath)
                cell.bind(row.viewModel)
                return cell
            })
    }
}
