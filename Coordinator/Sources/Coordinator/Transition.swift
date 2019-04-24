//
//  Transition.swift
//  Coordinator
//
//  Created by 이광용 on 23/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//
import UIKit.UIWindow

public enum Transition {
    case root(in: UIWindow)
    case present
    case push
}

