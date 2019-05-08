//
//  EventProtocol.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol EventProtocol {
    var uuid: String { get }
    var countingType: CountingType { get }
}
