//
//  RxTimePickerViewDelegateProxy.swift
//  TimerX
//
//  Created by 이광용 on 11/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxTimePickerViewDelegateProxy: DelegateProxy<TimerPickerView, TimerPickerViewDelegate>, TimerPickerViewDelegate, DelegateProxyType {
    static func registerKnownImplementations() {
        register {
            RxTimePickerViewDelegateProxy(parentObject: $0, delegateProxy: self)
        }
    }
    static func currentDelegate(for object: TimerPickerView) -> TimerPickerViewDelegate? {
        return object.timerPickerViewDelegate
    }
    static func setCurrentDelegate(_ delegate: TimerPickerViewDelegate?,
                                   to object: TimerPickerView) {
        object.timerPickerViewDelegate = delegate
    }
}
