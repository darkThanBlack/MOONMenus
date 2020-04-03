//
//  ExamOptionCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///ExamOptionCell 用户事件
protocol ExamOptionCellDelegate: class {
    func examOptionEvent(cell: ExamOptionCell)
}

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
        
        loadConstraintsForExamOption(box: box)
    }
    
    private func loadConstraintsForExamOption(box: UIView) {
        
    }
    
    private lazy var option: Options = {
        let option = Options()
        return option
    }()
    
    //MARK: SubClass
    
    ///容器，负责 普通 | 错误 | 正确 状态显示
    class Options: UIView {
        
        //MARK: Interface
        
        enum State {
            case normal
            case right
            case wrong
        }
        ///选项状态
        private var state: State = .normal
        ///序号
        private var serial: String = " "
        
        enum DisplayState {
            case text
            case voice
            case image
        }
        ///内容样式
        var displayState: DisplayState { return .text }
        ///中间展示部分，子类页面容器
        var displayView: UIView = UIView()
        
        func configView(state: State, serial: String) {
            self.state = state
            self.serialLabel.text = serial
            
            self.layer.borderWidth = 1.0
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 5.0
            
            switch self.state {
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
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForBox(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForBox(box: UIView) {
            box.addSubview(serialLabel)
            box.addSubview(hintImageView)
            box.addSubview(displayView)
            
            loadConstraintsForBox(box: box)
        }
        
        private func loadConstraintsForBox(box: UIView) {
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
        
        private lazy var serialLabel: UILabel = {
            let serialLabel = UILabel()
            serialLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            serialLabel.textColor = ExamHelper.blackText()
            serialLabel.text = " "
            serialLabel.numberOfLines = 0
            serialLabel.textAlignment = .center
            return serialLabel
        }()

        private lazy var hintImageView: UIImageView = {
            let hintImageView = UIImageView()
            return hintImageView
        }()
        
        //MARK: SubClass
        
        ///文本类型
        private class Text: Options {
            
            //MARK: Interface
            
            override var displayState: ExamOptionCell.Options.DisplayState { return .text }
            
            var optionText: String? {
                didSet {
                    switch self.state {
                    case .normal:
                        textLabel.textColor = ExamHelper.blackText()
                    case .right:
                        textLabel.textColor = ExamHelper.green()
                    case .wrong:
                        textLabel.textColor = ExamHelper.red()
                    }
                    textLabel.text = self.optionText
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForText(box: displayView)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForText(box: UIView) {
                box.addSubview(textLabel)
                textLabel.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
            }
            
            private lazy var textLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
                textLabel.textColor = ExamHelper.blackText()
                textLabel.text = " "
                textLabel.numberOfLines = 0
                return textLabel
            }()
            
        }
        
        ///音频类型
        private class Voice: Options {
            
            //MARK: Interface
            
            override var displayState: ExamOptionCell.Options.DisplayState { return .voice }
            
            //MOON_TODO: load voice data...
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForVoice(box: displayView)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForVoice(box: UIView) {
                box.addSubview(voiceView)
                voiceView.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
            }
            
            private lazy var voiceView: UIView = {
                let voiceView = UIView()
                voiceView.backgroundColor = ExamHelper.orange()
                return voiceView
            }()
            
        }
        
        ///图片类型
        private class Image: Options {
            
            //MARK: Interface
            
            override var displayState: ExamOptionCell.Options.DisplayState { return .image }
            
            var imageUrl: String? {
                didSet {
                    //MOON__TODO: load image...
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForImage(box: displayView)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForImage(box: UIView) {
                box.addSubview(pictureView)
                pictureView.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
            }
            
            private lazy var pictureView: UIImageView = {
                let pictureView = UIImageView()
                pictureView.contentMode = .scaleAspectFill
                return pictureView
            }()
            
        }
    }

    class TextCell: ExamOptionCell {
        func configCell(dataSource: ExamOptionCellTextDataSource) {
            super.configCell(dataSource: dataSource)
            
            
        }
        
    }
    
    class VoiceCell: ExamOptionCell {
        
    }
    
    class ImageCell: ExamOptionCell {
        
    }
}

