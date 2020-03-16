//
//  LessonCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///LessonCell 数据源
protocol LessonCellDataSource {
    var title: String? { get }
    var time: String? { get }
    var author: String? { get }
    var counts: String? { get }
}

class LessonCell: UITableViewCell {
    
//MARK: Interface
        
    func configCell(dataSource: LessonCellDataSource) {
        titleLabel.text = dataSource.title ?? " "
        timeLabel.text = dataSource.time ?? " "
        authorLabel.text = dataSource.author
        countsLabel.text = dataSource.counts
    }
    
//MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForLesson(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: View
    
    private func loadViewsForLesson(box: UIView) {
        box.addSubview(titleLabel)
        box.addSubview(timeLabel)
        box.addSubview(authorLabel)
        box.addSubview(authorTagLabel)
        box.addSubview(countsLabel)

        loadConstraintsForLesson(box: box)
    }
    
    private func loadConstraintsForLesson(box: UIView) {
        
        authorLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(box.snp.bottom).offset(-10.0)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.left.equalTo(timeLabel.snp.right).offset(8.0)
        }
        authorTagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(authorLabel.snp.centerY)
            make.left.equalTo(authorLabel.snp.right)
            make.right.lessThanOrEqualTo(countsLabel.snp.left).offset(-22.0)
        }
        countsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.right.equalTo(box.snp.right).offset(-16.0)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel.textColor = LessonHelper.blackText()
        titleLabel.text = " "
        return titleLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 13.0)
        timeLabel.textColor = LessonHelper.lightGrayText()
        timeLabel.text = " "
        return timeLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 13.0)
        authorLabel.textColor = LessonHelper.lightGrayText()
        authorLabel.text = " "
        return authorLabel
    }()
    
    private lazy var authorTagLabel: UILabel = {
        let authorTagLabel = UILabel()
        authorTagLabel.font = UIFont.systemFont(ofSize: 13.0)
        authorTagLabel.textColor = LessonHelper.lightGrayText()
        authorTagLabel.text = "创建"
        return authorTagLabel
    }()
    
    private lazy var countsLabel: UILabel = {
        let countsLabel = UILabel()
        countsLabel.font = UIFont.systemFont(ofSize: 15.0)
        countsLabel.textColor = LessonHelper.grayText()
        countsLabel.text = " "
        return countsLabel
    }()
    
//MARK: Event
    
}

