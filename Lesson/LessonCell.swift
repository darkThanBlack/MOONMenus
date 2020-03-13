//
//  LessonCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///LessonCell 用户事件
protocol LessonCellDelegate: class {
    func LessonCellEvent()
}

///LessonCell 数据源
protocol LessonCellDataSource {
    
}

class LessonCell: UITableViewCell {
    
//MARK: Interface
    
    private weak var delegate: LessonCellDelegate?
    func bindCell(delegate: LessonCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: LessonCellDataSource) {
        
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
        
        
        loadConstraintsForLesson(box: box)
    }
    
    private func loadConstraintsForLesson(box: UIView) {
        
    }
    
//MARK: Event
    
}

