//
//  TimerPickerView.swift
//  TimerX
//
//  Created by 이광용 on 10/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
private extension Array where Element == Int {
    func closest(of element: Element) -> (Int, Int)? {
        if isEmpty { return nil }
        let closestValue = reduce(self[0]) { (x, y) in
            abs(x - element) > abs(y - element) ? y : x
        }
        guard let firstIndex = firstIndex(of: closestValue) else { return nil }
        return (closestValue, firstIndex)
    }
}

open class TimerPickerView: UIPickerView {
    public enum Mode {
        case hours, minutes, seconds, milliSeconds, hm, ms, hms, hms_ms
        fileprivate var datas: [TimeUnit] {
            switch self {
            case .hours: return [.hour]
            case .minutes: return [.minute]
            case .seconds: return [.second]
            case .milliSeconds: return [.milliSecond]
            case .hm: return [.hour, .minute]
            case .ms: return [.minute, .second]
            case .hms: return [.hour, .minute, .second]
            case .hms_ms: return [.hour, .minute, .second, .milliSecond]
            }
        }
    }
    // Initialize
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
        self.insertSubview(timeUnitLabelStackView, at: 0)
        invalidateIntrinsicContentSize()
        updateConstraintsIfNeeded()
        updateTimeUnitLabels()
    }
    open override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        timeUnitLabelStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    open override func reloadAllComponents() {
        super.reloadAllComponents()
        countDownDuration = 0
    }
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 70 * 4 + 5 * 3, height: 30 * 5 + 20)
    }
    public weak var timerPickerViewDelegate: TimerPickerViewDelegate?
    public var mode: Mode = .hms {
        didSet {
            reloadAllComponents()
            updateTimeUnitLabels()
        }
    }
    fileprivate let hourRows: [Hours] = [Int](0..<24)
    fileprivate var minuteRows: [Minutes] = [Int](0..<60)
    fileprivate var secondRows: [Seconds] = [Int](0..<60)
    fileprivate let milliSecondRows: [MilliSeconds] = [Int](0..<1000)
    private func rows(of timeUnit: TimeUnit) -> [Int] {
        switch timeUnit {
        case .hour: return hourRows
        case .minute: return minuteRows
        case .second: return secondRows
        case .milliSecond: return milliSecondRows
        }
    }
    private var timeUnits: [TimeUnit] {
        return mode.datas
    }
    private var time: Time = Time(timeInterval: 0) {
        didSet {
            timerPickerViewDelegate?.timerPickerView?(self,
                                                      selectedTime: time.asTimeInterval())
//            timerPickerViewDelegate?.timerPickerView(self,
//                                                   selectedTime: time.asTimeInterval())
        }
    }
    public var countDownDuration: TimeInterval = 0 {
        didSet {
            set(time: Time(timeInterval: countDownDuration),
                about: mode)
        }
    }
    public var minuteInterval: Minutes = 1 {
        didSet {
            if 2..<60 ~= minuteInterval && 60 % minuteInterval == 0 {
                minuteRows = Array(stride(from: 0, to: 60, by: minuteInterval))
            } else {
                minuteRows = [Int](0..<60)
            }
            reloadAllComponents()
        }
    }
    public var secondInterval: Seconds = 1 {
        didSet {
            if 2..<60 ~= secondInterval && 60 % secondInterval == 0 {
                secondRows = Array(stride(from: 0, to: 60, by: secondInterval))
            } else {
                secondRows = [Int](0..<60)
            }
            reloadAllComponents()
        }
    }
    private lazy var timeUnitLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private func updateTimeUnitLabels() {
        DispatchQueue.main.async {
            self.timeUnitLabelStackView.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            self.mode.datas
                .map { TimeUnitCell(timeUnit: $0) }
                .forEach {
                    self.timeUnitLabelStackView.addArrangedSubview($0)
                }
        }
    }
    private func set(time: Time, about mode: Mode) {
        let closestMinute = minuteRows.closest(of: time.minutes) ?? (0, 0)
        let closestSecond = secondRows.closest(of: time.seconds) ?? (0, 0)
        DispatchQueue.main.async {
            switch mode {
            case .hours:
                self.selectRow(time.hours, inComponent: 0, animated: true)
            case .minutes:
                self.selectRow(closestMinute.1, inComponent: 0, animated: true)
            case .seconds:
                self.selectRow(closestSecond.1, inComponent: 0, animated: true)
            case .milliSeconds:
                self.selectRow(time.milliSeconds, inComponent: 0, animated: true)
            case .hm:
                self.selectRow(time.hours, inComponent: 0, animated: true)
                self.selectRow(closestMinute.1, inComponent: 1, animated: true)
            case .ms:
                self.selectRow(closestMinute.1, inComponent: 0, animated: true)
                self.selectRow(closestSecond.1, inComponent: 1, animated: true)
            case .hms:
                self.selectRow(time.hours, inComponent: 0, animated: true)
                self.selectRow(closestMinute.1, inComponent: 1, animated: true)
                self.selectRow(closestSecond.1, inComponent: 2, animated: true)
            case .hms_ms:
                self.selectRow(time.hours, inComponent: 0, animated: true)
                self.selectRow(closestMinute.1, inComponent: 1, animated: true)
                self.selectRow(closestSecond.1, inComponent: 2, animated: true)
                self.selectRow(time.milliSeconds, inComponent: 3, animated: true)
            }
//            self.time = Time(milliSeconds: time.milliSeconds,
//                             seconds: closestSecond.0,
//                             minutes: closestMinute.0,
//                             hours: time.hours)
        }
    }
}
extension TimerPickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeUnits.count
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows(of: timeUnits[component]).count
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let timeUnit = timeUnits[component]
        let value = rows(of: timeUnit)[row]
        switch timeUnit {
        case .hour: time.hours = value
        case .minute: time.minutes = value
        case .second: time.seconds = value
        case .milliSecond: time.milliSeconds = value
        }
    }
}
extension TimerPickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let timeUnit = timeUnits[component]
        let cell = TimeValueCell(timeUnit: timeUnit)
        cell.titleLabel.text = String(describing: rows(of: timeUnit)[row])
        return cell
    }
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
