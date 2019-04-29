//
//  CombinationsViewController.swift
//  TimerX
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

internal class CombinationsViewController: UIViewController {
    var coordinator: CombinationCoordinator!
    @IBOutlet private weak var combinationTableView: UITableView!
    @IBAction func addButtonTap(_ sender: UIButton) {
        coordinator.coordinate(.create)
    }
}
