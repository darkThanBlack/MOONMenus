//
//  ExamQuestionCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamQuestionCell 用户事件
protocol ExamQuestionCellDelegate: class {
    func ExamQuestionCellEvent()
}

///ExamQuestionCell 数据源
protocol ExamQuestionCellDataSource {
    
}

class ExamQuestionCell: UITableViewCell {
    
    //MARK: Interface
    
    private weak var delegate: ExamQuestionCellDelegate?
    func bindCell(delegate: ExamQuestionCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: ExamQuestionCellDataSource) {
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamQuestion(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamQuestion(box: UIView) {
        
        
        loadConstraintsForExamQuestion(box: box)
    }
    
    private func loadConstraintsForExamQuestion(box: UIView) {
        
    }
    
    //MARK: Event
    
}

