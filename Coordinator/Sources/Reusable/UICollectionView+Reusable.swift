//
//  UICollectionView.swift
//  Coordinator
//
//  Created by 이광용 on 01/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    func register<ReusableCell>(nib: ReusableCell.Type = ReusableCell.self, bundle: Bundle?)
        where ReusableCell: UICollectionViewCell {
        register(UINib(nibName: nib.reuseIdentifier,
                            bundle: bundle),
                      forCellWithReuseIdentifier: nib.reuseIdentifier)
    }
    func register<ReusableCell>(class: ReusableCell.Type = ReusableCell.self)
        where ReusableCell: UICollectionViewCell {
        register(`class`, forCellWithReuseIdentifier: `class`.reuseIdentifier)
    }
    func dequeReusableCell<ReusableCell>(with cell: ReusableCell.Type = ReusableCell.self,
                                         for indexPath: IndexPath) -> ReusableCell
        where ReusableCell: UICollectionViewCell {
            guard let reusableCell =  dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier,
                                                  for: indexPath) as? ReusableCell else {
                                                    fatalError("\(cell.reuseIdentifier) isn't exist")
            }
            return reusableCell
    }
}
