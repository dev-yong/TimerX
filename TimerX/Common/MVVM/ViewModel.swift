//
//  ViewProtocol.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain

internal protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
