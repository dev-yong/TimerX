//
//  View.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

internal protocol ViewProtocol {
    associatedtype ViewModel: ViewModelProtocol
    var viewModel: ViewModel! { get set }
    func bind(_ viewModel: ViewModel)
}
