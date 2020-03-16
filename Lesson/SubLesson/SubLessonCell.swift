//
//  SubSubLessonCell.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/3/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///SubLessonCell 数据源
protocol SubLessonCellDataSource {
    var title: String? { get }
    var counts: String? { get }
}

class SubSubLessonCell: UITableViewCell {

//MARK: Interface
        
    func configCell(dataSource: SubLessonCellDataSource) {
//        titleLabel.text = dataSource.title ?? " "
//        countsLabel.text = dataSource.counts
    }
    
//MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForSubLesson(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: View
    
    private func loadViewsForSubLesson(box: UIView) {
        self.addSubview(titleLabel)
        self.addSubview(countsLabel)
        
        loadConstraintsForSubLesson(box: box)
    }
    
    private func loadConstraintsForSubLesson(box: UIView) {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-11.0)
        }
        countsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.equalTo(titleLabel.snp.right).offset(48.0)
        }
    }
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel.textColor = LessonHelper.blackText()
        titleLabel.text = " "
        return titleLabel
    }()
    
    private lazy var countsLabel: UILabel = {
        let countsLabel = UILabel()
        countsLabel.font = UIFont.systemFont(ofSize: 15.0)
        countsLabel.textColor = LessonHelper.grayText()
        countsLabel.text = " "
        return countsLabel
    }()

}
