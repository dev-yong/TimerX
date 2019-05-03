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
import Coordinator

internal class CombinationCreateViewController: UIViewController, ViewProtocol {
    private let saveBarButtonitem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    @IBOutlet private weak var eventTableView: UITableView!
    private let disposeBag = DisposeBag()
    internal var viewModel: CombinationCreateViewModel!
    override internal func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButton(saveBarButtonitem, animated: false)
        bind(viewModel)
        eventTableView.register(class: SegmentTableViewCell.self)
        eventTableView.rx.setDelegate(self)
        eventTableView.rx.setDataSource(self)
    }
    internal func bind(_ viewModel: CombinationCreateViewModel) {
        let input = CombinationCreateViewModel.Input(saveTrigger: saveBarButtonitem.rx.tap.asDriver())
        let output = viewModel.transform(input)
    }
}

extension CombinationCreateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SegmentTableViewCell.self, for: indexPath)
        return cell
    }
}
