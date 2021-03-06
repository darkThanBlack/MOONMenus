//
//  ExamEnglishCell.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/6.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamEnglishCell 数据源
protocol ExamEnglishCellDataSource {
    var text: String? { get }
    var rank: String? { get }
    var star: Int64 { get }
}

class ExamEnglishCell: UITableViewCell {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamEnglishCellDataSource) {
        englishLabel.text = dataSource.text
        rankLabel.text = dataSource.rank
        star.configStar(count: dataSource.star)
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamEnglish(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamEnglish(box: UIView) {
        box.addSubview(englishLabel)
        box.addSubview(voiceView)
        box.addSubview(singleLine)
        box.addSubview(rankLabel)
        box.addSubview(star)
        
        loadConstraintsForExamEnglish(box: box)
    }
    
    private func loadConstraintsForExamEnglish(box: UIView) {
        
        englishLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        rankLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        englishLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(8.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
        }
        voiceView.snp.makeConstraints { (make) in
            make.top.equalTo(englishLabel.snp.bottom).offset(16.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.height.equalTo(40.0)
        }
        singleLine.snp.makeConstraints { (make) in
            make.top.equalTo(voiceView.snp.bottom).offset(16.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.height.equalTo(0.5)
        }
        rankLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(singleLine.snp.bottom).offset(20.0)
        }
        star.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(rankLabel.snp.bottom).offset(8.0)
            make.bottom.equalTo(box.snp.bottom).offset(-26.0).priority(.low)
            make.height.equalTo(25.0)
        }
    }
    
    private lazy var englishLabel: UILabel = {
        let englishLabel = UILabel()
        englishLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        englishLabel.textColor = ExamHelper.blackText()
        englishLabel.text = " "
        englishLabel.numberOfLines = 0
        return englishLabel
    }()
    
    private lazy var voiceView: UIView = {
        let voiceView = UIView()
        voiceView.backgroundColor = ExamHelper.orange()
        return voiceView
    }()
    
    private lazy var singleLine: UIView = {
        let singleLine = UIView()
        singleLine.backgroundColor = ExamHelper.grayBorder()
        return singleLine
    }()
    
    private lazy var rankLabel: UILabel = {
        let rankLabel = UILabel()
        rankLabel.font = UIFont.systemFont(ofSize: 23.0, weight: .medium)
        rankLabel.textColor = ExamHelper.blackText()
        rankLabel.text = " "
        rankLabel.numberOfLines = 0
        rankLabel.textAlignment = .center
        return rankLabel
    }()
    
    private lazy var star: ExamStar = {
        let star = ExamStar(maxCount: 3, style: .big)
        star.backgroundColor = ExamHelper.orange()
        return star
    }()
    

}

