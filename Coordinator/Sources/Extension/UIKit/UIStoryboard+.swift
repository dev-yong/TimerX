//
//  UIStoryboard+.swift
//  Coordinator
//
//  Created by 이광용 on 25/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UIStoryboard
extension UIStoryboard {
    public func instantiate<V>(viewController type: V.Type = V.self) -> V where V: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseIdentifier) as? V else {
            fatalError("\(type.reuseIdentifier) does not exist.")
        }
        return viewController
    }
}
