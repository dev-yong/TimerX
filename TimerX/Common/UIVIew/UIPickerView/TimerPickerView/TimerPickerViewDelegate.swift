//
//  TimerPickerViewDelegate.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
@objc
public protocol TimerPickerViewDelegate: AnyObject {
    @objc optional func timerPickerView(_ pickerView: TimerPickerView,
                                        selectedTime timeInterval: TimeInterval)
}
