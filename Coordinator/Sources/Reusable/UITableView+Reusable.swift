//
//  UITableView+Reusable.swift
//  Coordinator
//
//  Created by 이광용 on 01/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

extension UITableViewCell: Reusable {}

extension UITableView {
    public func register<ReusableCell>(nib: ReusableCell.Type = ReusableCell.self, bundle: Bundle?)
        where ReusableCell: UITableViewCell {
            register(UINib(nibName: nib.reuseIdentifier,
                           bundle: bundle),
                     forCellReuseIdentifier: nib.reuseIdentifier)
    }
    public func register<ReusableCell>(class: ReusableCell.Type = ReusableCell.self)
        where ReusableCell: UITableViewCell {
            self.register(`class`,
                          forCellReuseIdentifier: `class`.reuseIdentifier)
    }
    public func dequeueReusableCell<ReusableCell>(with cell: ReusableCell.Type = ReusableCell.self,
                                                  for indexPath: IndexPath) -> ReusableCell
        where ReusableCell: UITableViewCell {
            guard let reusableCell = self.dequeueReusableCell(withIdentifier: cell.reuseIdentifier,
                                                      for: indexPath) as? ReusableCell else {
                                                        fatalError("\(cell.reuseIdentifier) isn't exist")
            }
            return reusableCell
    }
}
