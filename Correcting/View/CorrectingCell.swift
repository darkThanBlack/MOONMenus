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
    func correctingInputEvent(cell: CorrectingCell)
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
                make.bottom.equalToSuperview().offset(-8.0)
                
                make.height.equalTo(0)
            }
        } else {
            editView.isHidden = false
            editView.snp.remakeConstraints { (make) in
                make.top.equalTo(inputHintsView.snp.bottom).offset(0)
                make.left.equalToSuperview().offset(16.0)
                make.right.equalToSuperview().offset(-16.0)
                make.bottom.equalToSuperview().offset(-8.0)
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
    private var editView: CorrectEditView = {
        let editView = CorrectEditView()
        editView.backgroundColor = CorrectingHelper.red()
        return editView
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

    class CorrectEditView: UIView {
        
        //MARK: Interface
        
        private var events: ((CorrectingCell.Events, CorrectingCell.EventsObject, [String: Any]?) -> Void)?
        func bindCell(events: ((CorrectingCell.Events, CorrectingCell.EventsObject, [String: Any]?) -> Void)?) {
            self.events = events
        }
        
        private var views: [DeleteView] = []
        
        var corrects = CorrectingCellModel.Corrects()
        
        ///父类负责子类宽度；子类负责自身高度
        func reloadSubViews(corrects: CorrectingCellModel.Corrects) {
            teacher.avatar = corrects.teacher.avatar
            teacher.name = corrects.teacher.name
            
            teacher.snp.remakeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(23.0)
                make.left.equalTo(self.snp.left).offset(16.0)
            }
            
            for item in views {
                item.removeFromSuperview()
            }
            views.removeAll()
            
            for (index, voice) in corrects.voices.enumerated() {
                let item = VoiceView()
                item.vid = voice.vid
                views.append(item)
                
                self.addSubview(item)
                item.tag = index
                item.bindDelete {
                    self.events?(.delete, .voice, ["index": item.tag])
                }
            }
            
            if corrects.review.isEditing {
                let review = ReviewsView()
                review.text = corrects.review.text
                views.append(review)
                
                self.addSubview(review)
                review.tag = views.count - 1
                review.bindDelete {
                    self.events?(.delete, .text, nil)
                }
                review.bindUpdate { (text) in
                    self.events?(.update, .text, ["text": text ?? ""])
                }
            }
                        
            if views.count == 0 {
                assert(true, "MOON__Assert  不可能，要展示点评页面必然有点名数据")
            }
            
            if views.count == 1 {
                let item = views.first
                item?.snp.remakeConstraints({ (make) in
                    make.top.equalTo(teacher.snp.bottom).offset(8.0)
                    make.left.equalTo(self.snp.left).offset(16.0)
                    make.right.equalTo(self.snp.right).offset(-16.0)
                    make.bottom.equalTo(self.snp.bottom).offset(-16.0)
                })
            } else {
                var tmpView = DeleteView()
                for (index, item) in views.enumerated() {
                    if (index == 0) {
                        item.snp.remakeConstraints { (make) in
                            make.top.equalTo(teacher.snp.bottom).offset(8.0)
                            make.left.equalTo(self.snp.left).offset(16.0)
                            make.right.equalTo(self.snp.right).offset(-16.0)
                        }
                    } else if (index == (views.count - 1)) {
                        item.snp.remakeConstraints { (make) in
                            make.top.equalTo(tmpView.snp.bottom).offset(8.0)
                            make.left.equalTo(tmpView.snp.left).offset(0)
                            make.right.equalTo(tmpView.snp.right).offset(-0)
                            
                            make.bottom.equalTo(self.snp.bottom).offset(-16.0)
                        }
                    } else {
                        item.snp.remakeConstraints { (make) in
                            make.top.equalTo(tmpView.snp.bottom).offset(8.0)
                            make.left.equalTo(tmpView.snp.left).offset(0)
                            make.right.equalTo(tmpView.snp.right).offset(-0)
                        }
                    }
                    tmpView = item
                }
            }
            
            //?
            
        }
        
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
            box.addSubview(teacher)
            
            loadConstraintsForCorrecting(box: box)
        }
        
        private func loadConstraintsForCorrecting(box: UIView) {
            
        }
        
        private lazy var teacher: TeacherView = {
            let teacher = TeacherView()
            return teacher
        }()
        
        //MARK: Event
        
        //MARK: - SubClass
        
        ///豫定本类实现，用于处理删除逻辑
        class DeleteView: UIView {
            
            //MARK: Interface
            
            private var delete: (() -> Void)?
            func bindDelete(event: (() -> Void)?) {
                self.delete = event
            }
            
            ///豫定子类实现，用于具体点评内容展示和相应逻辑
            var contentView = UIView()
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForDelete(box: self)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForDelete(box: UIView) {
                box.addSubview(contentView)
                box.addSubview(deleteEvent)
                box.addSubview(deleteImageView)
                
                loadConstraintsForDelete(box: box)
            }
            
            private func loadConstraintsForDelete(box: UIView) {
                
                contentView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                contentView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                
                contentView.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(box.snp.left).offset(0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                }
                deleteImageView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(contentView.snp.centerY)
                    make.left.equalTo(contentView.snp.right).offset(10.0)
                    make.right.equalTo(box.snp.right).offset(-16.0)
                    make.width.equalTo(16.0)
                    make.height.equalTo(16.0)
                }
                deleteEvent.snp.makeConstraints { (make) in
                    make.centerX.equalTo(deleteImageView.snp.centerX)
                    make.centerY.equalTo(deleteImageView.snp.centerY)
                    make.width.equalTo(32.0)
                    make.height.equalTo(32.0)
                }
            }
            
            private lazy var deleteEvent: UIView = {
                let deleteEvent = UIView()
                deleteEvent.backgroundColor = .clear
                
                deleteEvent.isUserInteractionEnabled = true
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(deleteEvent(gesture:)))
                singleTap.numberOfTapsRequired = 1
                singleTap.numberOfTouchesRequired = 1
                deleteEvent.addGestureRecognizer(singleTap)
                
                return deleteEvent
            }()
            
            private lazy var deleteImageView: UIImageView = {
                let deleteImageView = UIImageView(image: UIImage(named: "moonShadow"))
                return deleteImageView
            }()
            
            //MARK: Event
            
            @objc private func deleteEvent(gesture: UITapGestureRecognizer) {
                delete?()
            }
            
        }
        
        ///老师信息，必然展示，无需删除
        class TeacherView: UIView {
            
            //MARK: Interface
            
            var avatar: String? {
                didSet {
                    avatarImageView.image = UIImage(named: avatar ?? "")
                }
            }
            
            var name: String? {
                didSet {
                    nameLabel.text = name
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForTeacher(box: self)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForTeacher(box: UIView) {
                box.addSubview(avatarImageView)
                box.addSubview(nameLabel)
                
                loadConstraintsForTeacher(box: box)
            }
            
            private func loadConstraintsForTeacher(box: UIView) {
                avatarImageView.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(box.snp.left).offset(0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                    make.width.equalTo(30.0)
                    make.height.equalTo(30.0)
                }
                nameLabel.snp.makeConstraints { (make) in
                    make.centerY.equalTo(avatarImageView.snp.centerY)
                    make.left.equalTo(avatarImageView.snp.right).offset(10.0)
                    make.right.equalTo(box.snp.right).offset(-0)
                }
            }
            
            private lazy var avatarImageView: UIImageView = {
                let avatarImageView = UIImageView(image: UIImage(named: "moonShadow"))
                avatarImageView.contentMode = .scaleAspectFill
                return avatarImageView
            }()
            
            private lazy var nameLabel: UILabel = {
                let nameLabel = UILabel()
                nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
                nameLabel.textColor = CorrectingHelper.blackText()
                nameLabel.text = " "
                return nameLabel
            }()
            
        }
        
        ///音频点评
        class VoiceView: DeleteView {
            
            //MARK: Interface
            
            var vid: String? {
                didSet {
                    mockVoice.text = vid
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForVoice(box: contentView)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForVoice(box: UIView) {
                box.addSubview(mockVoice)
                
                loadConstraintsForVoice(box: box)
            }
            
            private func loadConstraintsForVoice(box: UIView) {
                mockVoice.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(box.snp.left).offset(0.0)
                    make.right.lessThanOrEqualTo(box.snp.right).offset(-0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                    make.width.equalTo(150.0)
                    make.height.equalTo(40.0)
                }
            }
            
            private lazy var mockVoice: UILabel = {
                let mockVoice = UILabel()
                mockVoice.backgroundColor = CorrectingHelper.orange()
                
                mockVoice.layer.masksToBounds = true
                mockVoice.layer.cornerRadius = 15.0
                
                return mockVoice
            }()
            
        }
        
        ///文字点评
        class ReviewsView: DeleteView, UITextViewDelegate {
            
            //MARK: Interface
            
            private var update: ((String?) -> Void)?
            func bindUpdate(event: ((String?) -> Void)?) {
                self.update = event
            }
            
            var text: String? {
                didSet {
                    textView.text = text
                }
            }
            
            //MARK: Life Cycle
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                loadViewsForMarks(box: contentView)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            //MARK: View
            
            private func loadViewsForMarks(box: UIView) {
                box.addSubview(textView)
                
                loadConstraintsForMarks(box: box)
            }
            
            private func loadConstraintsForMarks(box: UIView) {
                textView.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(box.snp.left).offset(0)
                    make.right.equalTo(box.snp.right).offset(-0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                    make.height.equalTo(120.0)
                }
            }
            
            private lazy var textView: UITextView = {
                let textView = UITextView()
                textView.text = "500字以内"
                
                textView.layer.masksToBounds = true
                textView.layer.cornerRadius = 5.0
                textView.layer.borderColor = CorrectingHelper.singleLine().cgColor
                textView.layer.borderWidth = 1.0
                
                textView.delegate = self
                
                return textView
            }()
            
            //MARK: Event
            
            func textViewDidChange(_ textView: UITextView) {
                self.update?(textView.text)
            }
        }
        

    }

}

