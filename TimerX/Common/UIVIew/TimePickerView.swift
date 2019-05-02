//
//  TimePickerView.swift
//  TimerX
//
//  Created by 이광용 on 30/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

public enum TimeUnit: CustomStringConvertible {
    case hour, minute, second
    public var description: String {
        switch self {
        case .hour: return "hour"
        case .minute: return "minute"
        case .second: return "second"
        }
    }
    public var datas: [Int] {
        switch self {
        case .hour: return [Int](0..<24)
        case .minute: return [Int](0..<60)
        case .second: return [Int](0..<60)
        }
    }
}

public protocol TimePickerViewDelegate: AnyObject {
    func timePickerView(_ pickerView: TimePickerView,
                        hour: Int,
                        minute: Int,
                        second: Int)
}

open class TimePickerView: UIPickerView {
    public enum Mode {
        case h, m, s, hm, ms, hms
        var datas: [TimeUnit] {
            switch self {
            case .h: return [.hour]
            case .m: return [.minute]
            case .s: return [.second]
            case .hm: return [.hour, .minute]
            case .ms: return [.minute, .second]
            case .hms: return [.hour, .minute, .second]
            }
        }
    }
    public var mode: Mode = .hms {
        didSet {
            reloadAllComponents()
        }
    }
    private var modeDataSource: [TimeUnit] {
        return mode.datas
    }
    private var time: [TimeUnit: Int] = [:] {
        didSet {
            timePickerViewDelegate?.timePickerView(self,
                                                   hour: time[.hour] ?? 0,
                                                   minute: time[.minute] ?? 0,
                                                   second: time[.second] ?? 0)
        }
    }
    public weak var timePickerViewDelegate: TimePickerViewDelegate?
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    private func initialize() {
        self.delegate = self
        self.dataSource = self
    }
    public func set(hour: Int, minute: Int, second: Int, animated: Bool) {
        assert(hour < 24 && minute < 60 && second < 60)
        DispatchQueue.main.async {
            switch self.mode {
            case .h:
                self.selectRow(hour, inComponent: 0, animated: animated)
            case .m:
                self.selectRow(minute, inComponent: 0, animated: animated)
            case .s:
                self.selectRow(second, inComponent: 0, animated: animated)
            case .hm:
                self.selectRow(hour, inComponent: 0, animated: animated)
                self.selectRow(minute, inComponent: 1, animated: animated)
            case .ms:
                self.selectRow(minute, inComponent: 0, animated: animated)
                self.selectRow(second, inComponent: 1, animated: animated)
            case .hms:
                self.selectRow(hour, inComponent: 0, animated: animated)
                self.selectRow(minute, inComponent: 1, animated: animated)
                self.selectRow(second, inComponent: 2, animated: animated)
            }
            self.time = [.hour: hour,
                         .minute: minute,
                         .second: second]
        }
    }
}

extension TimePickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return modeDataSource.count
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modeDataSource[component].datas.count
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let timeUnit = modeDataSource[component]
        let value = timeUnit.datas[row]
        time[timeUnit] = value
    }
}
extension TimePickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: modeDataSource[component].datas[row])
    }
}
