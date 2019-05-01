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

internal class CombinationCreateViewController: UIViewController, ViewProtocol {
    private let saveBarButtonitem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    @IBOutlet private weak var eventTableView: UITableView!
    private let disposeBag = DisposeBag()
    internal var viewModel: CombinationCreateViewModel!
    override internal func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButton(saveBarButtonitem, animated: false)
        bind(viewModel)
    }
    internal func bind(_ viewModel: CombinationCreateViewModel) {
        let input = CombinationCreateViewModel.Input(saveTrigger: saveBarButtonitem.rx.tap.asDriver())
        let output = viewModel.transform(input)
    }
}
