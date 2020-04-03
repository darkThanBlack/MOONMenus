//
//  ExamQuestionTextCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamQuestionTextCell 用户事件
protocol ExamQuestionTextCellDelegate: class {
    func ExamQuestionTextEvent(cell: ExamQuestionTextCell)
}

///ExamQuestionTextCell 数据源
protocol ExamQuestionTextCellDataSource {
    
}

class ExamQuestionTextCell: UITableViewCell {
    
    //MARK: Interface
    
    private weak var delegate: ExamQuestionTextCellDelegate?
    func bindCell(delegate: ExamQuestionTextCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: ExamQuestionTextCellDataSource) {
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamQuestionText(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamQuestionText(box: UIView) {
        box.addSubview(questionLabel)
        loadConstraintsForExamQuestionText(box: box)
    }
    
    private func loadConstraintsForExamQuestionText(box: UIView) {
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        questionLabel.textColor = ExamHelper.blackText()
        questionLabel.text = " "
        questionLabel.numberOfLines = 0
        return questionLabel
    }()

}

