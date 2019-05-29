//
//  Identifierable.swift
//  Domain
//
//  Created by 이광용 on 24/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol Identifierable {
    static var identifier: String { get }
}
