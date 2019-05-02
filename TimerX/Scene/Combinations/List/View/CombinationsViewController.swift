//
//  CombinationsViewController.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Designable
import RxSwift
import RxCocoa

internal class CombinationsViewController: UIViewController, ViewProtocol {
    @IBOutlet private weak var combinationTableView: UITableView!
    @IBOutlet private weak var createButton: DesignableButton!
    private let disposeBag = DisposeBag()
    internal var viewModel: CombinationListViewModel!
    override internal func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
    }
    internal func bind(_ viewModel: CombinationListViewModel) {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = CombinationListViewModel.Input(trigger: viewWillAppear,
                                                   createCombiationTrigger: createButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.createCombination
            .drive()
        .disposed(by: disposeBag)
    }
}
