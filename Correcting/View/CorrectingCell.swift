//
//  CorrectingCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingCell 用户事件
protocol CorrectingCellDelegate: class {
    func correctAddEvent(cell: CorrectingCell)
    func correctEditEvent(cell: CorrectingCell, event: CorrectingCell.Events, object: CorrectingCell.EventsObject, context: [String: Any]?)
}

///CorrectingCell 数据源
protocol CorrectingCellDataSource {
    var corrects: CorrectingCellModel.Corrects { get }
}

class CorrectingCell: UITableViewCell {
    
    //MARK: Interface
    
    ///用户事件
    enum Events {
        case delete
        case update
    }
    ///用户事件对象
    enum EventsObject {
        case voice
        case text
    }
    
    ///豫定由子类实现，负责展示学生提交的作业
    lazy var workView: UIView = {
        let workView = UIView()
        return workView
    }()
    
    private weak var delegate: CorrectingCellDelegate?
    func bindCell(delegate: CorrectingCellDelegate) {
        self.delegate = delegate
        self.editView.bindCell { (event, object, context) in
            self.delegate?.correctEditEvent(cell: self, event: event, object: object, context: context)
        }
    }
    
    func configCell(dataSource: CorrectingCellDataSource) {
        if dataSource.corrects.isEmpty {
            editView.isHidden = true
            editView.snp.remakeConstraints { (make) in
                make.top.equalTo(inputHintsView.snp.bottom).offset(0)
                make.left.equalToSuperview().offset(16.0)
                make.right.equalToSuperview().offset(-16.0)
                make.bottom.equalToSuperview().offset(-8.0).priority(.low)
                
                make.height.equalTo(0)
            }
        } else {
            editView.isHidden = false
            editView.snp.remakeConstraints { (make) in
                make.top.equalTo(inputHintsView.snp.bottom).offset(0)
                make.left.equalToSuperview().offset(16.0)
                make.right.equalToSuperview().offset(-16.0)
                make.bottom.equalToSuperview().offset(-8.0).priority(.low)
            }
        }
        editView.reloadSubViews(corrects: dataSource.corrects)
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
        box.addSubview(editView)
        
        loadConstraintsForCorrectingInput(box: box)
    }
    
    private func loadConstraintsForCorrectingInput(box: UIView) {
        workView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(8.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
        }
        inputHintsView.snp.makeConstraints { (make) in
            make.top.equalTo(workView.snp.bottom).offset(4.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
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
    private var editView: CorrectEditView = {
        let editView = CorrectEditView()
        return editView
    }()

    //MARK: Event
    
    @objc private func inputHintsViewEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctAddEvent(cell: self)
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
            let hints = UIImageView(image: UIImage(named: "moonShadow"))
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
}

