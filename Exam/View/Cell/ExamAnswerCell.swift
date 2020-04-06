//
//  ExamAnswerCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamAnswerCell 数据源
protocol ExamAnswerCellDataSource {
    var correctAnswer: String? { get }
}

///正确答案
class ExamAnswerCell: UITableViewCell {
    
    //MARK: Interface
        
    func configCell(dataSource: ExamAnswerCellDataSource) {
        answerLabel.text = dataSource.correctAnswer
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamAnswer(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamAnswer(box: UIView) {
        box.addSubview(answerLabel)
        
        loadConstraintsForExamAnswer(box: box)
    }
    
    private func loadConstraintsForExamAnswer(box: UIView) {
        answerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(26.0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-24.0)
        }
    }
    
    private lazy var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        hintLabel.textColor = ExamHelper.lightGrayText()
        hintLabel.text = "正确答案"
        return hintLabel
    }()
    
    private lazy var answerLabel: UILabel = {
        let answerLabel = UILabel()
        answerLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        answerLabel.textColor = ExamHelper.heavyOrange()
        hintLabel.text = " "
        answerLabel.numberOfLines = 0
        return answerLabel
    }()
    
    
}

