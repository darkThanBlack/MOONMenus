//
//  ExamQuestionImageCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamQuestionImageCell 用户事件
protocol ExamQuestionImageCellDelegate: class {
    func ExamQuestionImageEvent(cell: ExamQuestionImageCell)
}

///ExamQuestionImageCell 数据源
protocol ExamQuestionImageCellDataSource {
    
}

class ExamQuestionImageCell: UITableViewCell {
    
    //MARK: Interface
    
    private weak var delegate: ExamQuestionImageCellDelegate?
    func bindCell(delegate: ExamQuestionImageCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: ExamQuestionImageCellDataSource) {
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamQuestionImage(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamQuestionImage(box: UIView) {
        box.addSubview(questionImageView)
        loadConstraintsForExamQuestionImage(box: box)
    }
    
    private func loadConstraintsForExamQuestionImage(box: UIView) {
        questionImageView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(questionImageView.snp.width).multipliedBy(9.0/16.0)
        }
    }
    
    private lazy var questionImageView: UIImageView = {
        let questionImageView = UIImageView(image: UIImage(named: "moonShadow"))
        questionImageView.contentMode = .scaleAspectFill
        return questionImageView
    }()
    
    //MARK: Event
    
}

