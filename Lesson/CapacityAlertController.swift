//
//  CapacityAlertView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//  校区备课文件容量提示

import UIKit

class CapacityAlertView: UIView {
    
//MARK: SubViews
    
    class HintsView: UIView {
        
        //MARK: Interface
        
        var isFull = false {
            didSet {
                loadConstraintsForHints(box: self)
            }
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForHints(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForHints(box: UIView) {
            box.addSubview(hintLabel)
            box.addSubview(maxLabel)
            loadConstraintsForHints(box: box)
        }
        
        private func loadConstraintsForHints(box: UIView) {
            if isFull {
                hintLabel.snp.remakeConstraints { (make) in
                    make.top.left.right.equalTo(box)
                }
                maxLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(hintLabel.snp.bottom).offset(4.0)
                    make.centerX.equalTo(box)
                    make.bottom.equalTo(box)
                }
            } else {
                hintLabel.snp.remakeConstraints { (make) in
                    make.top.left.right.bottom.equalTo(box)
                }
            }
        }
                
        private lazy var hintLabel: UILabel = {
            let hintLabel = UILabel()
            hintLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            hintLabel.textColor = LessonHelper.grayText()
            hintLabel.text = "已用0G/共0G"
            hintLabel.textAlignment = .center
            return hintLabel
        }()
        
        private lazy var maxLabel: UILabel = {
            let maxLabel = UILabel()
            maxLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
            maxLabel.textColor = LessonHelper.red()
            maxLabel.text = "容量已达上限"
            maxLabel.textAlignment = .center
            return maxLabel
        }()
        
    }

    class RoundIndicatorView: UIView {
        
        //MARK: Interface
        
        var process: CGFloat = 0.0 {
            didSet {
                self.setNeedsDisplay()
            }
        }
        
        //MARK: View
        
        private var roundLayer = CAShapeLayer()
        private var processLayer = CAShapeLayer()
        
        override func draw(_ rect: CGRect) {
            
            roundLayer.removeFromSuperlayer()
            processLayer.removeFromSuperlayer()
            
            let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.midX, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            roundLayer.path = path.cgPath
            roundLayer.lineWidth = 12.0
            roundLayer.strokeColor = LessonHelper.grayLayer().cgColor
            roundLayer.fillColor = UIColor.white.cgColor
            
            let processPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.midX, startAngle: .pi * 1.5, endAngle: .pi * (1.5 - 2 * self.process), clockwise: false)
            processLayer.path = processPath.cgPath
            processLayer.lineCap = .round
            processLayer.lineWidth = 12.0
            var color = LessonHelper.blue().cgColor
            if process > 0.8 {
                color = LessonHelper.red().cgColor
            } else if process > 0.6 {
                color = LessonHelper.orange().cgColor
            }
            processLayer.strokeColor = color
            processLayer.fillColor = UIColor.clear.cgColor
            
            self.layer.addSublayer(roundLayer)
            self.layer.addSublayer(processLayer)
        }
    }

    //MARK: Interface
    
    var process: CGFloat = 0.0 {
        didSet {
            self.indicator.process = self.process
            self.hints.isFull = self.process == 1.0
        }
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForCapacityAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCapacityAlert() {
        self.addSubview(indicator)
        self.addSubview(hints)
        self.addSubview(titleLabel)
        
        loadConstraintsForCapacityAlert()
    }
    
    private func loadConstraintsForCapacityAlert() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        indicator.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40.0)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150.0)
            make.left.equalToSuperview().offset(60.0)
            make.right.equalToSuperview().offset(-60.0)
            make.bottom.equalToSuperview().offset(-40.0)
        }
        hints.snp.makeConstraints { (make) in
            make.center.equalTo(indicator.snp.center)
        }
    }
    
    ///圆形指示器
    private lazy var indicator: RoundIndicatorView = {
        let indicator = RoundIndicatorView()
        indicator.backgroundColor = .clear
        return indicator
    }()
        
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        titleLabel.textColor = LessonHelper.blackText()
        titleLabel.text = "校区备课文件储存容量"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var hints: HintsView = {
        let hintsView = HintsView()
        return hintsView
    }()
}

///校区备课文件容量提示
class CapacityAlertController: UIViewController {
    
    //MARK: Interface
    
    var progress: CGFloat = 0.0 {
        didSet {
            capacity.process = self.progress
        }
    }
    
    //MARK: Life Cycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.88)
        }
        loadViewsForCapacityAlert(box: boxView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForCapacityAlert() {
        
    }
    
    private func loadViewsForCapacityAlert(box: UIView) {
        box.addSubview(capacity)
        box.addSubview(singleLine)
        box.addSubview(closeButton)
        
        loadConstraintsForCapacityAlert(box: box)
    }
    
    private func loadConstraintsForCapacityAlert(box: UIView) {
        capacity.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        singleLine.snp.makeConstraints { (make) in
            make.top.equalTo(capacity.snp.bottom).offset(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(singleLine.snp.bottom).offset(0)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    private lazy var boxView: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = LessonHelper.background()
        boxView.layer.cornerRadius = 12.0
        boxView.layer.masksToBounds = true
        return boxView
    }()
    
    private lazy var capacity: CapacityAlertView = {
        let capacity = CapacityAlertView()
        capacity.backgroundColor = .white
        return capacity
    }()
    
    private lazy var singleLine: UIView = {
        let singleLine = UIView()
        singleLine.backgroundColor = LessonHelper.singleLine()
        return singleLine
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.backgroundColor = LessonHelper.background()
        closeButton.setTitle("关闭", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        closeButton.setTitleColor(LessonHelper.blueText(), for: .normal)
        closeButton.setTitleColor(LessonHelper.blueText().withAlphaComponent(0.7), for: .highlighted)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return closeButton
    }()
        
    //MARK: Data
    
    //MARK: Event
    
    @objc private func closeButtonPressed() {
        self.dismiss(animated: false, completion: nil)
    }

}


