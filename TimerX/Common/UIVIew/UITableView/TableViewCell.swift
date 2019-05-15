//
//  TableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 02/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UITableView
import RxSwift

@IBDesignable
class TableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    func initialize() {
        textLabel?.font = Configuration.Font.cellTitle
        backgroundColor = .clear
        selectionStyle = .none
    }
    @IBInspectable var highlightedBackgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3)
    private lazy var cachedBackgroundColor = backgroundColor
    override func setHighlighted(_ highlighted: Bool,
                                 animated: Bool) {
        super.setHighlighted(highlighted,
                             animated: animated)
        UIView.animate(withDuration: 0.3) {
            if highlighted {
                self.cachedBackgroundColor = self.backgroundColor
                self.backgroundColor = self.highlightedBackgroundColor
            } else {
                self.backgroundColor = self.cachedBackgroundColor
            }
        }
    }
}
