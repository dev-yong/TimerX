//
//  StoryboardProtocol.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit.UIStoryboard
import UIKit.UIViewController

public protocol StoryboardProtocol {
    var name: String { get }
    var bundle: Bundle? { get }
    func instantiate() -> UIStoryboard
}
extension StoryboardProtocol {
    public func instantiate() -> UIStoryboard {
        return UIStoryboard.init(name: name, bundle: bundle)
    }
}
extension UIStoryboard {
    public func instantiate(viewController: UIViewController.Type) -> UIViewController {
        return instantiateViewController(withIdentifier: viewController.reuseIdentifier)
    }
}
