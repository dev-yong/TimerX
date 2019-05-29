//
//  UseCaseProvider.swift
//  Domain
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeActionCombinationUseCase() -> ActionCombinationUseCase
    func makeActionUseCase() -> ActionUseCase
}
