//
//  ExamStepView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/8.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

protocol ExamStepViewDelegate: class {
    func examStepEvent(event: ExamStepView.Event)
}

///答题记录/测评模块详情 - 底部 上一题/下一题
class ExamStepView: UIView {
    
    //MARK: Interface
    
    enum Event {
        case previous
        case next
    }
    
    enum State {
        case disable
        case first
        case middle
        case last
    }
    
    private weak var delegate: ExamStepViewDelegate?
    func bindView(delegate: ExamStepViewDelegate) {
        self.delegate = delegate
    }
    
    func configView(state: State) {
        switch state {
        case .disable:
            leftButton.updateView(isEnabled: false)
            rightButton.updateView(isEnabled: false)
        case .first:
            leftButton.updateView(isEnabled: false)
            rightButton.updateView(isEnabled: true)
        case .last:
            leftButton.updateView(isEnabled: true)
            rightButton.updateView(isEnabled: false)
        case .middle:
            leftButton.updateView(isEnabled: true)
            rightButton.updateView(isEnabled: true)
        }
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForExamStep(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamStep(box: UIView) {
        box.addSubview(leftButton)
        box.addSubview(rightButton)
        box.addSubview(singleLine)
        
        loadConstraintsForExamStep(box: box)
    }
    
    private func loadConstraintsForExamStep(box: UIView) {
        singleLine.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.height.equalTo(0.5)
        }
        
        leftButton.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
        rightButton.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var singleLine: UIView = {
        let singleLine = UIView()
        singleLine.backgroundColor = ExamHelper.grayBorder()
        return singleLine
    }()

    private lazy var leftButton: Left = {
        let leftButton = Left()
        leftButton.backgroundColor = .white
        
        leftButton.tag = 0
        leftButton.isUserInteractionEnabled = false
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(buttonEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        leftButton.addGestureRecognizer(singleTap)
        
        return leftButton
    }()
    
    private lazy var rightButton: Right = {
        let rightButton = Right()
        rightButton.backgroundColor = .white
        
        rightButton.tag = 1
        rightButton.isUserInteractionEnabled = false
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(buttonEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        rightButton.addGestureRecognizer(singleTap)
        
        return rightButton
    }()
    
    //MARK: Event
    
    @objc private func buttonEvent(gesture: UITapGestureRecognizer) {
        let event: Event = gesture.view?.tag == 0 ? .previous : .next
        self.delegate?.examStepEvent(event: event)
    }
    
    //MARK: - SubClass
        
    class Left: UIView {
        
        //MARK: Interface
        
        func updateView(isEnabled: Bool) {
            self.isUserInteractionEnabled = isEnabled
            let theme = isEnabled ? ExamHelper.orange() : ExamHelper.border()
            arrow.updateArrow(color: theme)
            titleLabel.textColor = theme
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForLeft(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForLeft(box: UIView) {
            box.addSubview(arrow)
            box.addSubview(titleLabel)
            
            loadConstraintsForLeft(box: box)
        }
        
        private func loadConstraintsForLeft(box: UIView) {
            
            arrow.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(box.snp.left).offset(0)
                make.width.equalTo(12.0)
                make.height.equalTo(12.0)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(arrow.snp.right).offset(2.0)
                make.right.equalTo(box.snp.right).offset(-0)
            }
        }
        
        private lazy var arrow: ExamArrow = {
            let arrow = ExamArrow()
            arrow.updateArrow(color: ExamHelper.border() ,direction: .left)
            return arrow
        }()
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = ExamHelper.border()
            titleLabel.text = "上一题"
            titleLabel.textAlignment = .left
            return titleLabel
        }()

    }

    class Right: UIView {
        
        //MARK: Interface
        
        func updateView(isEnabled: Bool) {
            self.isUserInteractionEnabled = isEnabled
            let theme = isEnabled ? ExamHelper.orange() : ExamHelper.border()
            arrow.updateArrow(color: theme)
            titleLabel.textColor = theme
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForRight(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForRight(box: UIView) {
            box.addSubview(arrow)
            box.addSubview(titleLabel)
            
            loadConstraintsForRight(box: box)
        }
        
        private func loadConstraintsForRight(box: UIView) {
            arrow.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(box.snp.right).offset(0)
                make.width.equalTo(12.0)
                make.height.equalTo(12.0)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(arrow.snp.left).offset(-2.0)
                make.left.equalTo(box.snp.left).offset(-0)
            }
        }
        
        private lazy var arrow: ExamArrow = {
            let arrow = ExamArrow()
            arrow.updateArrow(color: ExamHelper.border(), direction: .right)
            return arrow
        }()
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = ExamHelper.border()
            titleLabel.text = "下一题"
            titleLabel.textAlignment = .right
            return titleLabel
        }()
        
    }
    
    
}

