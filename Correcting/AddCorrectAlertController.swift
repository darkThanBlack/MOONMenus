//
//  AddCorrectAlertController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/20.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///批改作业 - 添加点评
class AddCorrectAlertController: UIViewController {
    
    //MARK: Interface
    
    enum Style {
        case voice
        case text
    }
    private var complete: ((Style) -> Void)?
    func correctSelected(complete: ((Style) -> Void)?) {
        self.complete = complete
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
        
        loadViewsForAddCorrectAlert(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForAddCorrectAlert() {
        
    }
    
    private func loadViewsForAddCorrectAlert(box: UIView) {
        bgView.addSubview(voiceView)
        bgView.addSubview(textsView)
        
        box.addSubview(bgView)
        box.addSubview(cancelButton)
        
        loadConstraintsForAddCorrectAlert(box: box)
    }
    
    private func loadConstraintsForAddCorrectAlert(box: UIView) {
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(44.0)
        }
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(cancelButton.snp.top).offset(-0)
            make.height.equalTo(140.0)
        }
        
        loadConstraintsForAddCorrectAlertItem(box: bgView)
    }
    
    private func loadConstraintsForAddCorrectAlertItem(box: UIView) {
        voiceView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(30.0)
            make.left.equalTo(box.snp.left).offset(84.0)
        }
        textsView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(30.0)
            make.right.equalTo(box.snp.right).offset(-84.0)
        }
    }
    
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = CorrectingHelper.background()
        return bgView
    }()
    
    private lazy var voiceView: ItemView = {
        let voiceView = ItemView()
        voiceView.hint = "moonShadow"
        voiceView.title = "语音点评"
        
        voiceView.tag = 0
        voiceView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(itemViewEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        voiceView.addGestureRecognizer(singleTap)
        
        return voiceView
    }()
    
    private lazy var textsView: ItemView = {
        let textsView = ItemView()
        textsView.hint = "moonShadow"
        textsView.title = "文字点评"
        
        textsView.tag = 1
        textsView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(itemViewEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        textsView.addGestureRecognizer(singleTap)

        return textsView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.backgroundColor = .white
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        cancelButton.setTitleColor(CorrectingHelper.blackText(), for: .normal)
        cancelButton.setTitleColor(CorrectingHelper.blackText().withAlphaComponent(0.6), for: .highlighted)
        cancelButton.addTarget(self, action: #selector(cancelButtonEvent), for: .touchUpInside)
        return cancelButton
    }()
            
    //MARK: Event
    
    @objc private func itemViewEvent(gesture: UITapGestureRecognizer) {
        let tag = gesture.view?.tag
        if tag == 0 {
            complete?(.voice)
        } else {
            complete?(.text)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonEvent() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SubClass
    
    class ItemView: UIView {
        
        //MARK: Interface
        
        var title: String? {
            didSet {
                titleLabel.text = title
            }
        }
        
        var hint: String? {
            didSet {
                hintImageView.image = UIImage(named: hint ?? "")
            }
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForItem(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            hintImageView.layer.masksToBounds = true
            hintImageView.layer.cornerRadius = hintImageView.bounds.height / 2.0
        }
        
        private func loadViewsForItem(box: UIView) {
            box.addSubview(hintImageView)
            box.addSubview(titleLabel)
            
            loadConstraintsForItem(box: box)
        }
        
        private func loadConstraintsForItem(box: UIView) {
            hintImageView.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.width.equalTo(56.0)
                make.height.equalTo(56.0)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(box.snp.centerX)
                make.top.equalTo(hintImageView.snp.bottom).offset(6)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
            }
        }
        
        private lazy var hintImageView: UIImageView = {
            let hintImageView = UIImageView()
            return hintImageView
        }()
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
            titleLabel.textColor = CorrectingHelper.grayText()
            titleLabel.text = " "
            titleLabel.textAlignment = .center
            return titleLabel
        }()
    }
    
}
