//
//  Designable.swift
//  Designable
//
//  Created by 이광용 on 28/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

public protocol Designable: AnyObject {
    var cornerRadius: CGFloat { get set }
    var shadowOffset: CGSize { get set }
    var shadowOpacity: Float { get set }
    var shadowColor: UIColor? { get set }
    var shadowRadius: CGFloat { get set }
}
