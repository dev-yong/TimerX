//
//  UIViewController+Reusable.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UIViewController
extension UIViewController: Reusable {
    public static func instantiateNib<T: UIViewController>(bundle: Bundle?) -> T {
        return T(nibName: T.reuseIdentifier, bundle: bundle)
    }
}
