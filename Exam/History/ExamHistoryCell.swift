//
//  ExamHistoryCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/8.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamHistoryCell 数据源
protocol ExamHistoryCellDataSource {
    var title: String? { get }
    var star: Int64 { get }
    var times: String? { get }
}

class ExamHistoryCell: UITableViewCell {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamHistoryCellDataSource) {
        titleLabel.text = dataSource.title
        star.configStar(count: dataSource.star)
        timeLabel.text = dataSource.times
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamHistory(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamHistory(box: UIView) {
        box.addSubview(titleLabel)
        box.addSubview(tagLabel)
        box.addSubview(hintLabel)
        box.addSubview(star)
        box.addSubview(timeLabel)
        box.addSubview(arrow)
        
        loadConstraintsForExamHistory(box: box)
    }
    
    private func loadConstraintsForExamHistory(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.equalTo(titleLabel.snp.right).offset(4.0)
            make.right.lessThanOrEqualTo(arrow.snp.left).offset(-16.0)
            make.width.equalTo(38.0)
            make.height.equalTo(16.0)
        }
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalTo(titleLabel.snp.left).offset(0)
            make.bottom.equalTo(box.snp.bottom).offset(-12.0).priority(.low)
        }
        star.snp.makeConstraints { (make) in
            make.centerY.equalTo(hintLabel.snp.centerY)
            make.left.equalTo(hintLabel.snp.right).offset(4.0)
            make.height.equalTo(16.0)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(star.snp.centerY)
            make.left.equalTo(star.snp.right).offset(40.0)
            make.right.lessThanOrEqualTo(arrow.snp.left).offset(-16.0)
        }
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.right.equalTo(box.snp.right).offset(-10.0)
            make.width.equalTo(14.0)
            make.height.equalTo(14.0)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.textColor = ExamHelper.blackText()
        titleLabel.text = " "
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        tagLabel.textColor = ExamHelper.orange()
        tagLabel.text = "最新"
        tagLabel.textAlignment = .center
        tagLabel.isHidden = true
        
        tagLabel.layer.borderColor = ExamHelper.orange().cgColor
        tagLabel.layer.borderWidth = 1.0
        tagLabel.layer.masksToBounds = true
        tagLabel.layer.cornerRadius = 2.0
        
        return tagLabel
    }()
    
    private lazy var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        hintLabel.textColor = ExamHelper.lightGrayText()
        hintLabel.text = "得分："
        return hintLabel
    }()
    
    private lazy var star: ExamStar = {
        let star = ExamStar(maxCount: 5, style: .middle)
        return star
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        timeLabel.textColor = ExamHelper.lightGrayText()
        timeLabel.text = " "
        return timeLabel
    }()
    
    private lazy var arrow: ExamArrow = {
        let arrow = ExamArrow()
        arrow.updateArrow(color: ExamHelper.lightGrayText(), direction: .right)
        return arrow
    }()
}

