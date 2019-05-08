//
//  CellHeightCachable.swift
//  TimerX
//
//  Created by 이광용 on 07/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import UIKit
protocol CellHeightCachable: AnyObject {
    var cellHeightsDictionary: [String: CGFloat] { get set }
}
