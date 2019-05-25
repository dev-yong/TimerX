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
    let inset = Configuration.Dimension.inset
    let titleHeight = Configuration.Dimension.TableView.titleHeight
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
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "iconClose"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return button
    }()
    lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        return tableView
    }()
    var cellHeightsDictionary = [String: CGFloat]()
    override func initialize() {
        super.initialize()
        contentView.addSubview(containerView)
        containerView.addSubview(roundContainerView)
        roundContainerView.addSubview(titleContainerView)
        titleContainerView.addSubview(iconImageView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(closeButton)
        roundContainerView.addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        roundContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(inset)
        }
        titleContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tableView.snp.top)
            $0.height.equalTo(titleHeight).priority(999)
        }
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalTo(titleLabel.snp.leading).inset(-inset/2)
            $0.height.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(closeButton.snp.leading).inset(inset)
        }
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(closeButton.snp.height)
        }
        tableView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension EventTableViewCell: CellHeightCachable, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightsDictionary[indexPath.cacheKey] = cell.frame.size.height
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightsDictionary[indexPath.cacheKey] ?? UITableView.automaticDimension
    }
}
