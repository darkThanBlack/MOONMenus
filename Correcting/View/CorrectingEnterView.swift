//
//  CorrectingEnterView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/21.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class CorrectingEnterView: UIView {
    
    //MARK: Interface
    
    enum Styles {
        ///未批改过
        case fresh
        ///已批改过
        case edited
        ///不能批改，只能查看记录
        case noLimit
        ///不展示
        case none
    }
    var style = Styles.none
    
    func configView(style: Styles) {
        boxView.snp.updateConstraints { (make) in
            make.height.equalTo(40.0)
        }
        
        switch style {
        case .fresh:
            correctingView.title = "批改作业"
            
            correctingView.isHidden = false
            historyView.isHidden = true
            
            correctingView.snp.remakeConstraints { (make) in
                make.top.left.right.bottom.equalToSuperview()
            }
            
        case .edited:
            correctingView.title = "重新批改"
            
            correctingView.isHidden = false
            historyView.isHidden = false
            
            correctingView.snp.remakeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
            }
            historyView.snp.remakeConstraints { (make) in
                make.left.equalTo(correctingView.snp.right).offset(16.0)
                make.top.right.bottom.equalToSuperview()
                make.width.equalTo(correctingView.snp.width)
            }
            
        case .noLimit:
            correctingView.isHidden = true
            historyView.isHidden = false
            
            historyView.snp.remakeConstraints { (make) in
                make.top.left.right.bottom.equalToSuperview()
            }
            
        case .none:
            correctingView.isHidden = true
            historyView.isHidden = true
            
            boxView.snp.updateConstraints { (make) in
                make.height.equalTo(0)
            }
        }
    }
    
    enum Events {
        ///批改作业
        case correct
        ///查看历史记录
        case history
    }
    func bindView(event: ((Events) -> Void)?) {
        event?(.correct)
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(40.0)
        }
        loadViewsForCorrectingEnter(box: boxView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingEnter(box: UIView) {
        box.addSubview(correctingView)
        box.addSubview(historyView)
        
        loadConstraintsForCorrectingEnter(box: box)
    }
    
    private func loadConstraintsForCorrectingEnter(box: UIView) {
        
    }
    
    private lazy var boxView: UIView = {
        let boxView = UIView()
        return boxView
    }()
    
    private lazy var correctingView: ItemView = {
        let correctingView = ItemView()
        correctingView.imageName = "moonShadow"
        return correctingView
    }()
    
    private lazy var historyView: ItemView = {
        let historyView = ItemView()
        historyView.imageName = "moonShadow"
        historyView.title = "查看批改记录"
        return historyView
    }()
    
    //MARK: Event
    
    
    //MARK: - SubClass
    
    class ItemView: UIView {
        
        //MARK: Interface
        
        var imageName: String? {
            didSet {
                hintImageView.image = UIImage(named: imageName ?? "")
            }
        }
        
        var title: String? {
            didSet {
                titleLabel.text = title
            }
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.addSubview(boxView)
            boxView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            loadViewsForItem(box: boxView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForItem(box: UIView) {
            box.addSubview(hintImageView)
            box.addSubview(titleLabel)
            
            loadConstraintsForItem(box: box)
        }
        
        private func loadConstraintsForItem(box: UIView) {
            hintImageView.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.width.equalTo(20.0)
                make.height.equalTo(20.0)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(hintImageView.snp.right).offset(4.0)
                make.right.equalTo(box.snp.right).offset(-0)
            }
        }
        
        private lazy var boxView: UIView = {
            let boxView = UIView()
            return boxView
        }()

        private lazy var hintImageView: UIImageView = {
            let hintImageView = UIImageView()
            return hintImageView
        }()

        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = CorrectingHelper.orange()
            titleLabel.text = " "
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            return titleLabel
        }()
        
    }

}

