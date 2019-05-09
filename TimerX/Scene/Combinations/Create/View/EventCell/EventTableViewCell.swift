//
//  EventTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import Designable

class EventTableViewCell: TableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var roundContainerView: DesignableView = {
        let view = DesignableView()
        view.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    private lazy var titleContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 241/255, blue: 246/255, alpha: 1.0)
        return view
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 10
        return stackView
    }()
//    lazy var iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .blue
//        return imageView
//    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
//    lazy var closeButton: DesignableButton = {
//        let button = DesignableButton()
//        button.backgroundColor = .red
//        return button
//    }()
    lazy var tableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        return tableView
    }()
    override func initialize() {
        super.initialize()
        contentView.addSubview(containerView)
        containerView.addSubview(roundContainerView)
        roundContainerView.addSubview(titleContainerView)
        titleContainerView.addSubview(titleStackView)
//        titleStackView.addArrangedSubview(iconImageView)
        titleStackView.addArrangedSubview(titleLabel)
//        titleStackView.addArrangedSubview(closeButton)
        roundContainerView.addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        roundContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        titleContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tableView.snp.top)
            $0.height.equalTo(44).priority(999)
        }
        titleStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
//        iconImageView.snp.makeConstraints {
//            $0.width.height.equalTo(30).priority(999)
//        }
//        closeButton.snp.makeConstraints {
//            $0.width.height.equalTo(44-20).priority(999)
//        }
        tableView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    var cellHeightsDictionary = [String: CGFloat]()
}

extension EventTableViewCell: CellHeightCachable, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightsDictionary[indexPath.cacheKey] = cell.frame.size.height
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightsDictionary[indexPath.cacheKey] ?? UITableView.automaticDimension
    }
}
