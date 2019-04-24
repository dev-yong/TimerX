//
//  StoryboardProtocol.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

public protocol StoryboardProtocol {
    var name: String { get }
    var bundle: Bundle? { get }
    func `init`() -> UIStoryboard
    func instantiate(viewController: UIViewController.Type)
}
