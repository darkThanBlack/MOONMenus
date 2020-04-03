//
//  ExamQuestionVoiceCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamQuestionVoiceCell 用户事件
protocol ExamQuestionVoiceCellDelegate: class {
    func examQuestionVoiceEvent(cell: ExamQuestionVoiceCell)
}

///ExamQuestionVoiceCell 数据源
protocol ExamQuestionVoiceCellDataSource {
    
}

class ExamQuestionVoiceCell: UITableViewCell {
    
    //MARK: Interface
    
    private weak var delegate: ExamQuestionVoiceCellDelegate?
    func bindCell(delegate: ExamQuestionVoiceCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: ExamQuestionVoiceCellDataSource) {
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamQuestionVoice(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamQuestionVoice(box: UIView) {
        box.addSubview(voiceView)
        
        loadConstraintsForExamQuestionVoice(box: box)
    }
    
    private func loadConstraintsForExamQuestionVoice(box: UIView) {
        voiceView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(44.0)
        }
    }
    
    private lazy var voiceView: UIView = {
        let voiceView = UIView()
        voiceView.backgroundColor = .orange
        return voiceView
    }()
    
    
}

