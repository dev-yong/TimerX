//
//  TimePickerView.swift
//  TimerX
//
//  Created by 이광용 on 30/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit

enum TimeUnit: CustomStringConvertible {
    case hour, miniute, second
    var description: String {
        switch self {
        case .hour: return "hour"
        case .miniute: return "miniute"
        case .second: return "second"
        }
    }
    var datas: [Int] {
        switch self {
        case .hour: return [Int](0..<24)
        case .miniute: return [Int](0..<60)
        case .second: return [Int](0..<60)
        }
    }
}

class TimePickerView: UIPickerView {
    enum Mode {
        case h, m, s, hm, ms, hms
        var datas: [TimeUnit] {
            switch self {
            case .h: return [.hour]
            case .m: return [.miniute]
            case .s: return [.second]
            case .hm: return [.hour, .miniute]
            case .ms: return [.miniute, .second]
            case .hms: return [.hour, .miniute, .second]
            }
        }
    }
    var mode: Mode = .hms {
        didSet {
            reloadAllComponents()
        }
    }
    private var modeDataSource: [TimeUnit] {
        return mode.datas
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    private func initialize() {
        self.delegate = self
        self.dataSource = self
    }
}

extension TimePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return modeDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modeDataSource[component].datas.count
    }
}
extension TimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: modeDataSource[component].datas[row])
    }
}
