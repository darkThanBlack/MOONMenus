//
//  ExamHeader.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/6.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///Section Header
class ExamHeader {
    
    ///单选/多选
    class Option: UITableViewHeaderFooterView {
        
        //MARK: Interface
        
        var title: String? {
            didSet {
                titleLabel.text = self.title
            }
        }
        
        //MARK: Life Cycle
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            loadViewsForOption(box: self.contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForOption(box: UIView) {
            
            box.backgroundColor = ExamHelper.background()
            
            box.addSubview(bgView)
            box.addSubview(titleLabel)
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(15.0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.height.equalTo(52.0)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(bgView.snp.top).offset(16.0)
                make.left.equalTo(bgView.snp.left).offset(16.0)
                make.bottom.equalTo(bgView.snp.bottom).offset(4.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            titleLabel.textColor = ExamHelper.lightGrayText()
            titleLabel.text = " "
            return titleLabel
        }()
        
        private lazy var bgView: UIView = {
            let bgView = UIView()
            bgView.backgroundColor = .white
            return bgView
        }()

    }
    
    ///正确答案
    class Answer: UITableViewHeaderFooterView {
        
        //MARK: Life Cycle
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            loadViewsForAnswer(box: self.contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForAnswer(box: UIView) {
            
            box.backgroundColor = .white
            
            box.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(26.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-6.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            titleLabel.textColor = ExamHelper.lightGrayText()
            titleLabel.text = "正确答案"
            return titleLabel
        }()
        
    }

    
    ///英语测评
    class English: UITableViewHeaderFooterView {
        
        //MARK: Life Cycle
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            loadViewsForEnglish(box: self.contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForEnglish(box: UIView) {
            
            box.backgroundColor = ExamHelper.background()
            
            box.addSubview(bgView)
            box.addSubview(titleLabel)
            box.addSubview(sign1)
            box.addSubview(sign2)
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(15.0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.height.equalTo(52.0)
            }

            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(16.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.bottom.equalTo(box.snp.bottom).offset(4.0)
            }
            sign2.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(box.snp.right).offset(-16.0)
            }
            sign1.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(sign2.snp.left).offset(-16.0)
            }
            
        }
        
        private lazy var bgView: UIView = {
            let bgView = UIView()
            bgView.backgroundColor = .white
            return bgView
        }()
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            titleLabel.textColor = ExamHelper.lightGrayText()
            titleLabel.text = "口语测评"
            return titleLabel
        }()
        
        private lazy var sign1: Sign = {
            let sign1 = Sign()
            sign1.configView(state: .level1)
            return sign1
        }()
        
        private lazy var sign2: Sign = {
            let sign2 = Sign()
            sign2.configView(state: .level2)
            return sign2
        }()
        
        private class Sign: UIView {
            
            //MARK: Interface
            
            enum State {
                case level1
                case level2
            }
            
            func configView(state: State) {
                switch state {
                case .level1:
                    hintView.backgroundColor = ExamHelper.green()
                    titleLabel.text = "优秀"
                case .level2:
                    hintView.backgroundColor = ExamHelper.red()
                    titleLabel.text = "待加强"
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForSign(box: self)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForSign(box: UIView) {
                box.addSubview(hintView)
                box.addSubview(titleLabel)
                
                loadConstraintsForSign(box: box)
            }
            
            private func loadConstraintsForSign(box: UIView) {
                
                hintView.layer.cornerRadius = 5.0
                hintView.layer.masksToBounds = true
                
                hintView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(box.snp.centerY)
                    make.left.equalTo(box.snp.left).offset(0)
                    make.width.equalTo(10.0)
                    make.height.equalTo(10.0)
                }
                titleLabel.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(hintView.snp.right).offset(8.0)
                    make.right.equalTo(box.snp.right).offset(-0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                }
            }
            
            private lazy var hintView: UIView = {
                let hintView = UIView()
                hintView.backgroundColor = ExamHelper.green()
                return hintView
            }()
            
            private lazy var titleLabel: UILabel = {
                let titleLabel = UILabel()
                titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
                titleLabel.textColor = ExamHelper.blackText()
                return titleLabel
            }()
            
            
        }
        
        
    }
    
    ///点击查看解析
    class Explan: UITableViewHeaderFooterView {
        
        //MARK: Interface
        
        private var explan: (() -> Void)?
        ///绑定点击事件
        func bindEvent(explan: (() -> Void)?) {
            self.explan = explan
        }
        
        //MARK: Life Cycle
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            loadViewsForExplan(box: self.contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForExplan(box: UIView) {
            
            box.backgroundColor = ExamHelper.background()
                        
            explanButton.layer.masksToBounds = true
            explanButton.layer.cornerRadius = 14.0
            
            box.addSubview(explanButton)
            
            explanButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(box.snp.centerX)
                make.top.equalTo(box.snp.top).offset(16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-16.0)
                make.height.equalTo(28.0)
            }
        }
        
        private lazy var explanButton: UIButton = {
            let explanButton = UIButton(type: .custom)
            explanButton.backgroundColor = ExamHelper.background()
            explanButton.setTitle("点击查看解析", for: .normal)
            explanButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            explanButton.setTitleColor(ExamHelper.lightGrayText(), for: .normal)
            explanButton.setTitleColor(ExamHelper.lightGrayText().withAlphaComponent(0.6), for: .highlighted)
            explanButton.addTarget(self, action: #selector(explanButtonEvent), for: .touchUpInside)
                        
            return explanButton
        }()
        
        @objc private func explanButtonEvent() {
            self.explan?()
        }
    }
    
}

