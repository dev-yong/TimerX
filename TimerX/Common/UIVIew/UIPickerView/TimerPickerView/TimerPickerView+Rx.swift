//
//  TimerPickerView+Rx.swift
//  TimerX
//
//  Created by 이광용 on 11/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: TimerPickerView {
    private var rx_delegate: DelegateProxy<TimerPickerView, TimerPickerViewDelegate> {
        return RxTimePickerViewDelegateProxy.proxy(for: base)
    }
    public var selectedTimeInterval: Observable<TimeInterval> {
        return rx_delegate
            .methodInvoked(#selector(TimerPickerViewDelegate.timerPickerView(_:selectedTime:)))
            .map { $0[1] as? TimeInterval }
            .unwrap()
    }
}
