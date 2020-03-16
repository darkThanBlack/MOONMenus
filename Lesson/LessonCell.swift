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
        authorView.time = dataSource.time ?? " "
        authorView.author = dataSource.author
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
        box.addSubview(authorView)
        box.addSubview(countsLabel)

        loadConstraintsForLesson(box: box)
    }
    
    private func loadConstraintsForLesson(box: UIView) {
                
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
        }
        authorView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(countsLabel.snp.left).offset(-22.0)
            make.bottom.equalTo(box.snp.bottom).offset(-10.0).priority(.low)
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
    
    private lazy var authorView: LessonAuthorView = {
        let authorView = LessonAuthorView(theme: .gray)
        return authorView
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

