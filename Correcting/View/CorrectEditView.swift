//
//  CorrectEditView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/20.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class CorrectEditView: UIView {
    
    //MARK: Interface
    
    private var events: ((CorrectingCell.Events, CorrectingCell.EventsObject, [String: Any]?) -> Void)?
    func bindCell(events: ((CorrectingCell.Events, CorrectingCell.EventsObject, [String: Any]?) -> Void)?) {
        self.events = events
    }
    
    fileprivate var views: [DeleteView] = []
    
    ///父类负责子类宽度；子类负责自身高度
    func reloadSubViews(corrects: CorrectingCellModel.Corrects) {
        //教师信息
        teacher.avatar = corrects.teacher.avatar
        teacher.name = corrects.teacher.name
        
        for item in views {
            item.removeFromSuperview()
        }
        views.removeAll()
        
        //音频
        for (index, voice) in corrects.voices.enumerated() {
            let item = VoiceView(canEdit: corrects.canEdit)
            item.vid = voice.vid
            views.append(item)
            
            self.addSubview(item)
            item.tag = index
            item.bindDelete {
                self.events?(.delete, .voice, ["index": item.tag])
            }
        }
        
        //文字
        //用户添加 | 有文本内容时 展示 textView
        let needShow = corrects.review.isEditing ? true : (corrects.review.text.count > 0 ? true : false)
        if needShow {
            let review = ReviewEditView(canEdit: corrects.canEdit)
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
            var tmpView = UIView()
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
        self.setNeedsDisplay()
        
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
    
    private var shape: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = 1.0
        shape.strokeColor = CorrectingHelper.grayLayer().cgColor
        shape.fillColor = CorrectingHelper.background().cgColor
        return shape
    }()
    
    override func draw(_ rect: CGRect) {
        shape.removeFromSuperlayer()
        
        let path = drawBubble(box: self)
        shape.path = path.cgPath
        self.layer.insertSublayer(shape, at: 0)
    }
    
    private func loadViewsForCorrecting(box: UIView) {
        box.addSubview(teacher)
        
        loadConstraintsForCorrecting(box: box)
    }
    
    private func loadConstraintsForCorrecting(box: UIView) {
        teacher.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(23.0)
            make.left.equalTo(self.snp.left).offset(16.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-16.0).priority(.low)
        }
    }
    
    private lazy var teacher: TeacherView = {
        let teacher = TeacherView()
        return teacher
    }()
    
    private func drawBubble(box: UIView) -> UIBezierPath {
        let path = UIBezierPath()
        
        let line: CGFloat = 1.0
        let width = box.bounds.width
        let height = box.bounds.height
        let arrow_h: CGFloat = 8.0
        let rad: CGFloat = 5.0
        
        //左上开始顺时针
        let r1 = CGPoint(x: rad + line, y: rad + arrow_h + line)
        let r1_start = CGPoint(x: r1.x - rad, y: r1.y)
        
        let a1 = CGPoint(x: r1.x + 16.0, y: r1.y - rad)
        let a2 = CGPoint(x: a1.x + 8.0, y: a1.y - arrow_h)
        let a3 = CGPoint(x: a1.x + 16.0, y: a1.y)
        
        let r2 = CGPoint(x: width - rad - line, y: r1.y)
        let r2_start = CGPoint(x: r2.x, y: r2.y - rad)
        
        let r3 = CGPoint(x: r2.x, y: height - rad - line)
        let r3_start = CGPoint(x: r3.x + rad, y: r3.y)
        
        let r4 = CGPoint(x: r1.x, y: r3.y)
        let r4_start = CGPoint(x: r4.x, y: r4.y + rad)
        
        path.move(to: r1_start)
        path.addArc(withCenter: r1, radius: rad, startAngle: .pi, endAngle: 1.5 * .pi, clockwise: true)
        path.addLine(to: a1)
        path.addLine(to: a2)
        path.addLine(to: a3)
        path.addLine(to: r2_start)
        path.addArc(withCenter: r2, radius: rad, startAngle: 1.5 * .pi, endAngle: 2.0 * .pi, clockwise: true)
        path.addLine(to: r3_start)
        path.addArc(withCenter: r3, radius: rad, startAngle: 0, endAngle: 0.5 * .pi, clockwise: true)
        path.addLine(to: r4_start)
        path.addArc(withCenter: r4, radius: rad, startAngle: 0.5 * .pi, endAngle: .pi, clockwise: true)
        path.close()
        
        return path
    }
    
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
        
        ///业务上编辑状态不可改变
        required init(canEdit: Bool) {
            super.init(frame: .zero)
            
            loadViewsForDelete(box: self, canEdit: canEdit)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForDelete(box: UIView, canEdit: Bool) {
            box.addSubview(contentView)
            if canEdit {
                box.addSubview(deleteEvent)
                box.addSubview(deleteImageView)
            }
            
            loadConstraintsForDelete(box: box, canEdit: canEdit)
        }
        
        private func loadConstraintsForDelete(box: UIView, canEdit: Bool) {
            if canEdit {
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
                    make.right.equalTo(box.snp.right).offset(0)
                    make.width.equalTo(16.0)
                    make.height.equalTo(16.0)
                }
                deleteEvent.snp.makeConstraints { (make) in
                    make.centerX.equalTo(deleteImageView.snp.centerX)
                    make.centerY.equalTo(deleteImageView.snp.centerY)
                    make.width.equalTo(32.0)
                    make.height.equalTo(32.0)
                }
            } else {
                contentView.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
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
    
    ///老师信息，必然展示，无需继承
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
        
        required init(canEdit: Bool) {
            super.init(canEdit: canEdit)
            
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
    class ReviewEditView: DeleteView, UITextViewDelegate {
        
        //MARK: Interface
        
        private var update: ((String?) -> Void)?
        func bindUpdate(event: ((String?) -> Void)?) {
            self.update = event
        }
        
        var text: String? {
            didSet {
                textView.text = text
                reviewLabel.text = text
            }
        }
        
        //MARK: Life Cycle
        
        required init(canEdit: Bool) {
            super.init(canEdit: canEdit)
            
            loadViewsForMarks(box: contentView, canEdit: canEdit)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForMarks(box: UIView, canEdit: Bool) {
            if canEdit {
                box.addSubview(textView)
            } else {
                box.addSubview(reviewLabel)
            }
            loadConstraintsForMarks(box: box, canEdit: canEdit)
        }
        
        private func loadConstraintsForMarks(box: UIView, canEdit: Bool) {
            if canEdit {
                textView.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                    make.height.equalTo(120.0)
                }
            } else {
                reviewLabel.snp.makeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
            }
        }
        
        private lazy var textView: UITextView = {
            let textView = UITextView()
            textView.delegate = self
            textView.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            textView.textColor = CorrectingHelper.blackText()
            
            textView.layer.masksToBounds = true
            textView.layer.cornerRadius = 5.0
            textView.layer.borderColor = CorrectingHelper.singleLine().cgColor
            textView.layer.borderWidth = 1.0
            
            textView.text = "500字以内"
            
            return textView
        }()
        
        private lazy var reviewLabel: UILabel = {
            let reviewLabel = UILabel()
            reviewLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            reviewLabel.textColor = CorrectingHelper.blackText()
            reviewLabel.text = " "
            reviewLabel.numberOfLines = 0
            return reviewLabel
        }()
        
        //MARK: Event
        
        func textViewDidChange(_ textView: UITextView) {
            self.update?(textView.text)
        }
    }
    
}

