//
//  CorrectingInputCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingInputCell 用户事件
protocol CorrectingInputCellDelegate: class {
    func correctingInputEvent(cell: CorrectingInputCell)
}

///CorrectingInputCell 数据源
protocol CorrectingInputCellDataSource {
    var corrects: CorrectingCellModel.Corrects { get }
}

class CorrectingInputCell: UITableViewCell {
    
    //MARK: Interface
    
    ///豫定由子类实现，负责展示学生提交的作业
    lazy var workView: UIView = {
        let workView = UIView()
        return workView
    }()
    
    private weak var delegate: CorrectingInputCellDelegate?
    func bindCell(delegate: CorrectingInputCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingInputCellDataSource) {
        if dataSource.corrects.isEmpty {
            correctingView.snp.remakeConstraints { (make) in
                make.top.equalTo(inputHintsView.snp.bottom).offset(0)
                make.left.equalToSuperview().offset(16.0)
                make.right.equalToSuperview().offset(-16.0)
                make.bottom.equalToSuperview().offset(-8.0)
                
                make.height.equalTo(100.0)
            }
        } else {
            correctingView.snp.remakeConstraints { (make) in
                make.top.equalTo(inputHintsView.snp.bottom).offset(0)
                make.left.equalToSuperview().offset(16.0)
                make.right.equalToSuperview().offset(-16.0)
                make.bottom.equalToSuperview().offset(-8.0)
                
                make.height.equalTo(0)
            }
        }
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingInput(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingInput(box: UIView) {
        box.addSubview(workView)
        box.addSubview(inputHintsView)
        box.addSubview(correctingView)
        
        loadConstraintsForCorrectingInput(box: box)
    }
    
    private func loadConstraintsForCorrectingInput(box: UIView) {
        workView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            
        }
        inputHintsView.snp.makeConstraints { (make) in
            make.top.equalTo(workView.snp.bottom).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
        }
    }
    
    private lazy var inputHintsView: InputHintView = {
        let inputHintsView = InputHintView()
        
        inputHintsView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(inputHintsViewEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        inputHintsView.addGestureRecognizer(singleTap)
        
        return inputHintsView
    }()
    
    ///豫定由本类实现，负责处理添加老师的点评
    private var correctingView: UIView = {
        let correctingView = UIView()
        correctingView.backgroundColor = CorrectingHelper.red()
        return correctingView
    }()

    //MARK: Event
    
    @objc private func inputHintsViewEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctingInputEvent(cell: self)
    }
    
    //MARK: - SubClass
    
    ///"添加点评"按钮
    class InputHintView: UIView {
                
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForInputHint(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForInputHint(box: UIView) {
            box.addSubview(hints)
            box.addSubview(hintLabel)
            
            loadConstraintsForInputHint(box: box)
        }
        
        private func loadConstraintsForInputHint(box: UIView) {
            hints.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.bottom.equalTo(box.snp.bottom).offset(0)
                make.width.equalTo(20.0)
                make.height.equalTo(20.0)
            }
            hintLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(hints.snp.right).offset(4.0)
                make.right.equalTo(box.snp.right).offset(-0)
            }
        }
        
        private lazy var hints: UIImageView = {
            let hints = UIImageView(image: UIImage(named: ""))
            hints.backgroundColor = LessonHelper.grayText()
            return hints
        }()
        
        private lazy var hintLabel: UILabel = {
            let hintLabel = UILabel()
            hintLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            hintLabel.textColor = CorrectingHelper.grayText()
            hintLabel.text = "添加点评"
            return hintLabel
        }()
        
    }

    class CorrectingView: UIView {
        
        //MARK: Interface
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForCorrecting(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForCorrecting(box: UIView) {
            
            
            loadConstraintsForCorrecting(box: box)
        }
        
        private func loadConstraintsForCorrecting(box: UIView) {
            
        }
        
        //MARK: Event
        
        
    }

}

