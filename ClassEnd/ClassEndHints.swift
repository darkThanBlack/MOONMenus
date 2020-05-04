//
//  ClassEndHints.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/5/4.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ClassEndHint {
    
    @objc(ClassEndHintAlertController)
    class AlertController: UIViewController {
        
        //MARK: Interface
        
        init(studentName: String?, className: String?) {
            super.init(nibName: nil, bundle: nil)
            
            modalTransitionStyle = .crossDissolve
            modalPresentationStyle = .overCurrentContext
            
//            let para = NSMutableParagraphStyle()
//            para.lineSpacing = 18.0
            
            let attrNormal = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                NSMutableAttributedString.Key.foregroundColor: ClassEndHelper.grayText()
            ]
            let attrHint = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                NSMutableAttributedString.Key.foregroundColor: ClassEndHelper.heavyOrange()
            ]
            let attrDetail = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                NSMutableAttributedString.Key.foregroundColor: ClassEndHelper.red()
            ]
            
            let hint = NSMutableAttributedString(string: "你正在对", attributes: attrNormal)
            hint.append(NSAttributedString(string: studentName ?? "佚名", attributes: attrHint))
            hint.append(NSAttributedString(string: "的", attributes: attrNormal))
            hint.append(NSAttributedString(string: className ?? "课程", attributes: attrHint))
            hint.append(NSAttributedString(string: "进行结课操作。结课后，系统将进行如下处理，请仔细阅读并确认。", attributes: attrNormal))
            hintLabel.attributedText = hint
            
            
            let detail = NSMutableAttributedString(string: "1、学员在该课程下的所有", attributes: attrNormal)
            detail.append(NSAttributedString(string: "剩余课时将清零", attributes: attrDetail))
            detail.append(NSAttributedString(string: "且无法恢复；\n", attributes: attrNormal))
            
            detail.append(NSAttributedString(string: "2、学员将被", attributes: attrNormal))
            detail.append(NSAttributedString(string: "移出对应班级", attributes: attrDetail))
            detail.append(NSAttributedString(string: "，且已结课的课程不能参与后续教学流程（如点名、分班、排课、续费预警等）；\n", attributes: attrNormal))
            
            detail.append(NSAttributedString(string: "3、相关", attributes: attrNormal))
            detail.append(NSAttributedString(string: "点名记录、缺课记录、退转课记录将被锁定", attributes: attrDetail))
            detail.append(NSAttributedString(string: "，不能修改；\n", attributes: attrNormal))
            
            detail.append(NSAttributedString(string: "4、学员在该课程下如有超上的课时，将作忽略处理；\n", attributes: attrNormal))
            
            detail.append(NSAttributedString(string: "5、以上操作", attributes: attrNormal))
            detail.append(NSAttributedString(string: "不可撤销", attributes: attrDetail))
            detail.append(NSAttributedString(string: "，请提前核对好学员的相关记录。", attributes: attrNormal))
            
            detailLabel.attributedText = detail
        }
        
        //MARK: Life Cycle
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            view = UIView(frame: .zero)
            view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadViewsForClassEndHint(box: view)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        
        //MARK: Data
        
        private func loadRequestForClassEndHint() {
            
        }
        
        //MARK: View
        
        private func loadNavigationsForClassEndHint() {
            
        }
        
        private func loadViewsForClassEndHint(box: UIView) {
            box.addSubview(whiteView)
            box.addSubview(header)
            box.addSubview(hintLabel)
            box.addSubview(detailBox)
            box.addSubview(okButton)
            
            detailBox.addSubview(detailLabel)
            
            
            loadConstraintsForClassEndHint(box: box)
        }
        
        private func loadConstraintsForClassEndHint(box: UIView) {
            header.snp.makeConstraints { (make) in
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.height.equalTo(44.0)
            }
            whiteView.snp.makeConstraints { (make) in
                make.top.equalTo(header.snp.bottom).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
            }
            hintLabel.snp.makeConstraints { (make) in
                make.top.equalTo(header.snp.bottom).offset(12.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
            }
            detailBox.snp.makeConstraints { (make) in
                make.top.equalTo(hintLabel.snp.bottom).offset(16.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
            }
            okButton.snp.makeConstraints { (make) in
                make.top.equalTo(detailBox.snp.bottom).offset(16.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-16.0)
                make.height.equalTo(44.0)
            }
            
            loadConstraintsForDetailBox(box: detailBox)
        }
        
        private func loadConstraintsForDetailBox(box: UIView) {
            detailLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(16.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-16.0)
            }
        }
        
        private lazy var header: Header = {
            let header = Header()
            header.backgroundColor = .white
            header.bindEvent {
                self.dismiss(animated: true, completion: nil)
            }
            return header
        }()
        
        private lazy var whiteView: UIView = {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            return whiteView
        }()
        
        private lazy var hintLabel: UILabel = {
            let hintLabel = UILabel()
            hintLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            hintLabel.textColor = ClassEndHelper.grayText()
            hintLabel.text = " "
            hintLabel.numberOfLines = 0
            return hintLabel
        }()
        
        private lazy var detailBox: UIView = {
            let detailBox = UIView()
            detailBox.backgroundColor = ClassEndHelper.background()
            return detailBox
        }()
        
        private lazy var detailLabel: UILabel = {
            let detailLabel = UILabel()
            detailLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            detailLabel.textColor = ClassEndHelper.grayText()
            detailLabel.text = " "
            detailLabel.numberOfLines = 0
            return detailLabel
        }()
        
        private lazy var okButton: UIButton = {
            let okButton = UIButton(type: .custom)
            okButton.backgroundColor = .orange
            okButton.setTitle("确认结课", for: .normal)
            okButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            okButton.setTitleColor(.white, for: .normal)
            okButton.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
            okButton.addTarget(self, action: #selector(okButtonEvent), for: .touchUpInside)
            return okButton
        }()
        
        //MARK: Event
        
        @objc private func okButtonEvent() {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc(ClassEndHintHeader)
    class Header: UIView {
        
        //MARK: Interface
        
        private var close: (() -> Void)?
        func bindEvent(close: (() -> Void)?) {
            self.close = close
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForHeader(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private var shape = CAShapeLayer()
        override func draw(_ rect: CGRect) {
            shape.removeFromSuperlayer()
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
            shape.path = path.cgPath
            layer.mask = shape
        }
        
        private func loadViewsForHeader(box: UIView) {
            box.addSubview(titleLabel)
            box.addSubview(closeButton)
            box.addSubview(singleLine)
            
            loadConstraintsForHeader(box: box)
        }
        
        private func loadConstraintsForHeader(box: UIView) {
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(box.snp.left).offset(16.0)
            }
            closeButton.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.width.equalTo(30.0)
                make.height.equalTo(30.0)
            }
            singleLine.snp.makeConstraints { (make) in
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.height.equalTo(0.5)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
            titleLabel.textColor = CorrectingHelper.blackText()
            titleLabel.text = "结课提醒"
            return titleLabel
        }()
        
        private lazy var closeButton: UIButton = {
            let closeButton = UIButton(type: .custom)
            closeButton.setImage(UIImage(named: "moonShadow"), for: .normal)
            closeButton.addTarget(self, action: #selector(closeButtonEvent), for: .touchUpInside)
            return closeButton
        }()
        
        private lazy var singleLine: UIView = {
            let singleLine = UIView()
            singleLine.backgroundColor = CorrectingHelper.lightGrayText()
            return singleLine
        }()
        
        //MARK: Event
        
        @objc private func closeButtonEvent() {
            self.close?()
        }
        
    }

}
