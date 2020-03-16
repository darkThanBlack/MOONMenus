//
//  LessonAuthorView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonAuthorView: UIView {
    
    //MARK: Interface
    
    enum Themes {
        case gray
        case white
    }
    
    var time: String? = " " {
        didSet {
            timeLabel.text = time ?? " "
        }
    }
    
    var author: String? = "佚名" {
        didSet {
            authorLabel.text = author
        }
    }
    
    //MARK: Life Cycle
    
    required init(theme: Themes) {
        super.init(frame: .zero)
        switch theme {
        case .gray:
            self.timeLabel.textColor = LessonHelper.lightGrayText()
            self.authorLabel.textColor = LessonHelper.lightGrayText()
            self.authorTagLabel.textColor = LessonHelper.lightGrayText()
        case .white:
            self.timeLabel.textColor = .white
            self.authorLabel.textColor = .white
            self.authorTagLabel.textColor = .white
        }
        loadViewsForLessonAuthor(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForLessonAuthor(box: UIView) {
        box.addSubview(timeLabel)
        box.addSubview(authorLabel)
        box.addSubview(authorTagLabel)
        
        loadConstraintsForLessonAuthor(box: box)
    }
    
    private func loadConstraintsForLessonAuthor(box: UIView) {
        
        authorLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left)
            make.bottom.equalTo(box.snp.bottom).offset(0)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.left.equalTo(timeLabel.snp.right).offset(8.0)
        }
        authorTagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(authorLabel.snp.centerY)
            make.left.equalTo(authorLabel.snp.right)
            make.right.equalTo(box.snp.right).offset(0)
        }
    }
    
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
        authorLabel.text = "佚名"
        return authorLabel
    }()
    
    private lazy var authorTagLabel: UILabel = {
        let authorTagLabel = UILabel()
        authorTagLabel.font = UIFont.systemFont(ofSize: 13.0)
        authorTagLabel.textColor = LessonHelper.lightGrayText()
        authorTagLabel.text = "创建"
        return authorTagLabel
    }()
    
}
