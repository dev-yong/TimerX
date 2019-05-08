//
//  DynamicHeightTableView.swift
//  TimerX
//
//  Created by 이광용 on 04/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

class DynamicHeightTableView: TableView {
    var maxHeight: CGFloat?
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight ?? UIScreen.main.bounds.height)
        return CGSize(width: contentSize.width,
                      height: height)
    }
}
