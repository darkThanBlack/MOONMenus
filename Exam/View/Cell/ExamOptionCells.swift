//
//  ExamOptionCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///图片类型
protocol ExamOptionCellImageDataSource: ExamOptionCellDataSource {
    
}

///音频类型
protocol ExamOptionCellVoiceDataSource: ExamOptionCellDataSource {
    
}

///文本类型
protocol ExamOptionCellTextDataSource: ExamOptionCellDataSource {
    var optionText: String? { get }
}

///ExamOptionCell 数据源
protocol ExamOptionCellDataSource {
    var state: ExamOptionCell.Options.State { get }
    var serial: String? { get }
}

//protocol ExamOptionCellType where Self: ExamOptionCell {
//     func configCell(dataSource: ExamOptionCellDataSource)
//}
///单/多选，长条形选项
class ExamOptionCell: UITableViewCell {
    
    //MARK: Interface
    
    ///绑定通用数据，由子类调用
    private func configCell(dataSource: ExamOptionCellDataSource) {
        option.configView(state: dataSource.state, serial:  dataSource.serial ?? " ")
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForExamOption(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamOption(box: UIView) {
        box.addSubview(option)
        option.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(6.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-6.0).priority(.low)
        }
    }
        
    private lazy var option: Options = {
        let option = Options()
        return option
    }()
    
    //MARK: - SubClass
    
    ///容器，负责 普通 | 错误 | 正确 状态显示
    class Options: UIView {
        
        ///选项状态
        enum State {
            case normal
            case right
            case wrong
        }
        
        ///中间展示部分的页面容器
        var displayView: UIView = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForBox(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        ///选项序号
        private lazy var serialLabel: UILabel = {
            let serialLabel = UILabel()
            serialLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            serialLabel.textColor = ExamHelper.blackText()
            serialLabel.text = " "
            serialLabel.numberOfLines = 0
            serialLabel.textAlignment = .center
            return serialLabel
        }()
        ///正确/错误标识
        private lazy var hintImageView: UIImageView = {
            let hintImageView = UIImageView()
            return hintImageView
        }()
        
        
    }

    ///文字选项
    class Text: ExamOptionCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            loadViewsForExamOptionText(box: self.option.displayView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        ///文字内容
        private lazy var optionTextLabel: UILabel = {
            let optionTextLabel = UILabel()
            optionTextLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            optionTextLabel.textColor = ExamHelper.blackText()
            optionTextLabel.text = " "
            optionTextLabel.numberOfLines = 0
            return optionTextLabel
        }()
        
    }
    
    ///音频选项
    class Voice: ExamOptionCell {
        
        //MARK: Life Cycle
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            loadViewsForExamOptionVoice(box: self.option.displayView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        ///音频内容
        private lazy var voiceView: UIView = {
            let voiceView = UIView()
            voiceView.backgroundColor = ExamHelper.orange()
            return voiceView
        }()
        
    }
    
    class Image: ExamOptionCell {
        
        //MARK: Life Cycle
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            loadViewsForExamOptionImage(box: self.option.displayView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        ///图片内容
        private lazy var optionImageView: UIImageView = {
            let optionImageView = UIImageView()
            optionImageView.contentMode = .scaleAspectFill
            return optionImageView
        }()
        
        
    }
}

extension ExamOptionCell.Options {
    
    //MARK: Interface
    
    ///state: 选项状态  serial: 序号文本
    func configView(state: State, serial: String) {
        
        self.serialLabel.text = serial
        
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
        
        switch state {
        case .normal:
            self.layer.borderColor = ExamHelper.grayBorder().cgColor
            self.backgroundColor = .white
            serialLabel.textColor = ExamHelper.blackText()
            self.hintImageView.isHidden = true
        case .right:
            self.layer.borderColor = ExamHelper.green().cgColor
            self.backgroundColor = ExamHelper.green().withAlphaComponent(0.05)
            serialLabel.textColor = ExamHelper.green()
            self.hintImageView.isHidden = false
            self.hintImageView.image = UIImage(named: "exam_right")
        case .wrong:
            self.layer.borderColor = ExamHelper.red().cgColor
            self.backgroundColor = ExamHelper.red().withAlphaComponent(0.05)
            serialLabel.textColor = ExamHelper.red()
            self.hintImageView.isHidden = false
            self.hintImageView.image = UIImage(named: "exam_wrong")
        }
    }
    
    //MARK: View
    
    private func loadViewsForBox(box: UIView) {
        box.addSubview(serialLabel)
        box.addSubview(hintImageView)
        box.addSubview(displayView)
        
        loadConstraintsForBox(box: box)
    }
    
    private func loadConstraintsForBox(box: UIView) {
        
        serialLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        serialLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        displayView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        displayView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        serialLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.left.equalTo(box.snp.left).offset(16.0)
        }
        displayView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(16.0)
            make.left.equalTo(serialLabel.snp.right).offset(32.0)
            make.bottom.equalTo(box.snp.bottom).offset(-16.0).priority(.low)
            make.height.greaterThanOrEqualTo(22.0)
        }
        hintImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.left.equalTo(displayView.snp.right).offset(12.0)
            make.right.equalTo(box.snp.right).offset(-8.0)
            make.width.equalTo(24.0)
            make.height.equalTo(24.0)
        }
    }
    
    
}

extension ExamOptionCell.Text {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamOptionCellTextDataSource) {
        super.configCell(dataSource: dataSource)
        
        switch dataSource.state {
        case .normal:
            optionTextLabel.textColor = ExamHelper.blackText()
        case .right:
            optionTextLabel.textColor = ExamHelper.green()
        case .wrong:
            optionTextLabel.textColor = ExamHelper.red()
        }
        optionTextLabel.text = dataSource.optionText
    }
    
    //MARK: View

    private func loadViewsForExamOptionText(box: UIView) {
        box.addSubview(optionTextLabel)
        optionTextLabel.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(box)
        }
    }

}

extension ExamOptionCell.Voice {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamOptionCellVoiceDataSource) {
        super.configCell(dataSource: dataSource)
        
    }
    
    //MARK: View
    
    private func loadViewsForExamOptionVoice(box: UIView) {
        box.addSubview(voiceView)
        voiceView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(box)
            make.height.equalTo(40.0)
        }
    }
    
}

extension ExamOptionCell.Image {
    
    //MARK: Interface
    
    func configCell(dataSource: ExamOptionCellImageDataSource) {
        super.configCell(dataSource: dataSource)
    
    
    }
    
    //MARK: View
    
    private func loadViewsForExamOptionImage(box: UIView) {
        box.addSubview(optionImageView)
        optionImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(box)
            make.height.equalTo(40.0)
        }
    }


}
