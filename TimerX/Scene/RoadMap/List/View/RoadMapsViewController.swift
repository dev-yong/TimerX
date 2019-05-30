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

class RoadMapsViewController: UIViewController {
    @IBOutlet private weak var roadMapTableView: TableView!
    @IBOutlet private weak var createButton: DesignableButton!
    private let disposeBag = DisposeBag()
    var viewModel: RoadMapsViewModel!
    private var dataSource: RxTableViewSectionedReloadDataSource<RoadMapsSection>?
    override func viewDidLoad() {
        super.viewDidLoad()
        roadMapTableView.register(class: RoadMapTableViewCell.self)
        bind(viewModel)
    }
}
extension RoadMapsViewController: ViewProtocol {
    func bind(_ viewModel: RoadMapsViewModel) {
        dataSource = makeDataSource()
        guard let dataSource = self.dataSource else { return }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = RoadMapsViewModel.Input(trigger: viewWillAppear,
                                                   createRoadMapTrigger: createButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        [output.createRoadMap.drive(),
         output.roadMapsSections.drive(roadMapTableView.rx.items(dataSource: dataSource))].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedReloadDataSource<RoadMapsSection> {
        return RxTableViewSectionedReloadDataSource<RoadMapsSection>(
            configureCell: { (_, tableView, indexPath, row) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(with: RoadMapTableViewCell.self,
                                                         for: indexPath)
                cell.bind(row.viewModel)
                return cell
            })
    }
}
