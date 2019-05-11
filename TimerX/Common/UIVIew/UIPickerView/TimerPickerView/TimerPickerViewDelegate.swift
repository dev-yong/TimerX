//
//  TimerPickerViewDelegate.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
public protocol TimerPickerViewDelegate: AnyObject {
    func timerPickerView(_ pickerView: TimerPickerView,
                         selectedTime timeInterval: TimeInterval)
}
