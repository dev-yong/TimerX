//
//  IndexPath+.swift
//  TimerX
//
//  Created by 이광용 on 04/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
extension IndexPath {
    var cacheKey: String {
        return String(describing: self)
    }
}
