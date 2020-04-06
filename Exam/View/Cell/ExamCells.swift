//
//  ExamCell.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/5.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///文本类型
protocol ExamCellTextDataSource {
    var text: String? { get }
}

///音频类型
protocol ExamCellVoiceDataSource {
    
}

///图片类型
protocol ExamCellImageDataSource {
    var image: String? { get }
}

///测评题目
class ExamCell {
    
    ///图片类型
    class Image: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.selectionStyle = .none
            
            loadViewsForImage(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private lazy var examImageView: UIImageView = {
            let examImageView = UIImageView()
            examImageView.clipsToBounds = true
            examImageView.contentMode = .scaleAspectFill
            return examImageView
        }()

    }
    
    ///音频类型
    class Voice: UITableViewCell {
                
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.selectionStyle = .none
            
            loadViewsForVoice(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private lazy var voiceView: UIView = {
            let voiceView = UIView()
            voiceView.backgroundColor = ExamHelper.orange()
            return voiceView
        }()
        
    }
    
    ///文本类型
    class Text: UITableViewCell {
                
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.selectionStyle = .none
            
            loadViewsForText(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private lazy var examLabel: UILabel = {
            let examLabel = UILabel()
            examLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            examLabel.textColor = ExamHelper.blackText()
            examLabel.text = " "
            examLabel.numberOfLines = 0
            return examLabel
        }()

        
    }
    
}

extension ExamCell.Image {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamCellImageDataSource) {
        examImageView.image = UIImage(named: dataSource.image ?? "")
    }
    
    //MARK: View
    
    private func loadViewsForImage(box: UIView) {
        box.addSubview(examImageView)
        examImageView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(6.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-6.0)
            make.height.equalTo(examImageView.snp.width).multipliedBy(9.0/16.0)
        }
    }
    
}

extension ExamCell.Voice {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamCellVoiceDataSource) {
        
    }
    
    //MARK: View
    
    private func loadViewsForVoice(box: UIView) {
        box.addSubview(voiceView)
        
        voiceView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(6.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-6.0)
            make.height.equalTo(40.0)
        }
    }
    
}

extension ExamCell.Text {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamCellTextDataSource) {
        examLabel.text = dataSource.text
    }
    
    //MARK: View
    
    private func loadViewsForText(box: UIView) {
        box.addSubview(examLabel)
        
        examLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(6.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-6.0)
        }
    }
    
}
