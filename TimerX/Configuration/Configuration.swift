//
//  Configuration.swift
//  TimerX
//
//  Created by 이광용 on 05/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

enum Configuration {
    enum Font {
        static let cellTitle = UIFont.boldSystemFont(ofSize: 16.0)
    }
    enum Dimension {
        static let inset: CGFloat = 10.0
        enum TableView {
            static let titleHeight: CGFloat = 44.0
            static let rowHeight: CGFloat = 44.0
        }
    }
}
