//
//  StoryboardProtocol.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//
import UIKit.UIStoryboard
public protocol StoryboardProtocol {
    var name: String { get }
    var bundle: Bundle? { get }
    var instance: UIStoryboard { get }
}
extension StoryboardProtocol {
    public var instance: UIStoryboard {
        return UIStoryboard.init(name: name, bundle: bundle)
    }
}
