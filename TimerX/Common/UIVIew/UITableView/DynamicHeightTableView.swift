//
//  DynamicHeightTableView.swift
//  TimerX
//
//  Created by 이광용 on 04/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxCocoa

class DynamicHeightTableView: TableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    override var contentSize: CGSize {
        didSet {
            layoutIfNeeded()
        }
    }
    override func reloadData() {
        super.reloadData()
        layoutIfNeeded()
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width,
                      height: min(contentSize.height, maxHeight))
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        invalidateIntrinsicContentSize()
    }
}

extension TableView {
    var rx_contentSize: Driver<CGSize> {
        return rx.observeWeakly(CGSize.self,
                                "contentSize")
            .unwrap()
            .asDriverOnErrorJustComplete()
    }
}
