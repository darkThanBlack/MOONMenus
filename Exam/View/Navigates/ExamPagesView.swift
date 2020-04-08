//
//  ExamPages.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/7.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

protocol ExamPagesDelegate: class {
    func examPages(event: ExamPagesView.Event)
}

///答题记录/测评模块详情 - 上方章节导航
class ExamPagesView: UIView {
    
    //MARK: Interface
    
    enum Event {
        case item(index: Int)
        case arrow(isOpened: Bool)
    }
    
    ///标题数组
    var titles: [String] = []
    ///默认选中
    var index: Int64 = 0
    ///是否展开
    private var isOpened: Bool = false
    
    private weak var delegate: ExamPagesDelegate?
    func bindView(delegate: ExamPagesDelegate) {
        self.delegate = delegate
    }
    
    ///更新选中项
    func updateSelected(newIndex: Int) {
        self.reloadSelectItem(selectedIndex: newIndex)
    }
    
    ///触发按钮事件
    func updateOpenState() {
        self.arrowEvent(gesture: nil)
    }
    
    private var items: [Item] = []
    func configView(titles: [String], defIndex: Int64) {
        for item in items {
            item.removeFromSuperview()
        }
        items.removeAll()
        
        var tmpView = UIView()
        for (index, title) in titles.enumerated() {
            let item = Item()
            let state: Item.State = defIndex == index ? .selected : .normal
            item.configItem(state: state, title: title)
            
            contentView.addSubview(item)
            items.append(item)
            
            if index == 0 {
                item.snp.makeConstraints { (make) in
                    make.top.equalTo(contentView.snp.top).offset(0)
                    make.left.equalTo(contentView.snp.left).offset(16.0)
                    make.bottom.equalTo(contentView.snp.bottom).offset(-0)
                    make.height.equalTo(48.0)
                }
            } else if index == (titles.count - 1) {
                item.snp.makeConstraints { (make) in
                    make.centerY.equalTo(tmpView.snp.centerY)
                    make.left.equalTo(tmpView.snp.right).offset(20.0)
                    make.height.equalTo(tmpView.snp.height)
                    
                    make.right.equalTo(contentView.snp.right).offset(-16.0)
                }
            } else {
                item.snp.makeConstraints { (make) in
                    make.centerY.equalTo(tmpView.snp.centerY)
                    make.left.equalTo(tmpView.snp.right).offset(20.0)
                    make.height.equalTo(tmpView.snp.height)
                }
            }
            tmpView = item
            
            item.isUserInteractionEnabled = true
            item.tag = index
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(itemEvent(gesture:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            item.addGestureRecognizer(singleTap)
        }
        
    }
    
    private func reloadSelectItem(selectedIndex: Int) {
        for (index, item) in items.enumerated() {
            item.configItem(state: (selectedIndex == index) ? .selected : .normal, title: nil)
        }
    }
        
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForExamPages(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamPages(box: UIView) {
        box.addSubview(contentView)
        box.addSubview(arrow)
        
        loadConstraintsForExamPages(box: box)
    }
    
    private func loadConstraintsForExamPages(box: UIView) {
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.bottom.equalTo(box.snp.bottom).offset(0)
            make.height.equalTo(48.0)
        }
        arrow.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(contentView.snp.right).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.width.equalTo(arrow.snp.height)
        }
    }
    
    private lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.showsHorizontalScrollIndicator = false
        return contentView
    }()
    
    private lazy var arrow: UILabel = {
        let arrow = UILabel()
        arrow.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        arrow.textColor = ExamHelper.lightGrayText()
        arrow.text = "∨"
        arrow.textAlignment = .center
        
        arrow.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(arrowEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        arrow.addGestureRecognizer(singleTap)
                
        return arrow
    }()
    
    //MARK: Event
    
    @objc private func itemEvent(gesture: UITapGestureRecognizer) {
        let idx = gesture.view?.tag ?? 0
        reloadSelectItem(selectedIndex: idx)
        self.delegate?.examPages(event: .item(index: idx))
    }
    
    @objc private func arrowEvent(gesture: UITapGestureRecognizer?) {
        self.isOpened = !self.isOpened
        UIView.animate(withDuration: 0.15, animations: {
            self.arrow.transform = self.isOpened ? CGAffineTransform(rotationAngle: -.pi) : .identity
        }) { (finished) in
            
        }
        self.delegate?.examPages(event: .arrow(isOpened: self.isOpened))
    }
    
    //MARK: SubClass
    
    ///选项
    class Item: UIView {
        
        //MARK: Interface
        
        enum State {
            case normal
            case selected
        }
        func configItem(state: State, title: String?) {
            switch state {
            case .normal:
                titleLabel.textColor = ExamHelper.blackText()
                hintView.isHidden = true
            case .selected:
                titleLabel.textColor = ExamHelper.heavyOrange()
                hintView.isHidden = false
            }
            if title != nil {
                titleLabel.text = title
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
        
        private func loadViewsForItem(box: UIView) {
            box.addSubview(titleLabel)
            box.addSubview(hintView)
            
            loadConstraintsForItem(box: box)
        }
        
        private func loadConstraintsForItem(box: UIView) {
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
            }
            hintView.snp.makeConstraints { (make) in
                make.centerX.equalTo(box.snp.centerX)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.width.equalTo(20.0)
                make.height.equalTo(2.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = ExamHelper.blackText()
            titleLabel.text = " "
            titleLabel.textAlignment = .center
            return titleLabel
        }()
        
        private lazy var hintView: UIView = {
            let hintView = UIView()
            hintView.backgroundColor = ExamHelper.heavyOrange()
            hintView.isHidden = true
            return hintView
        }()
        
        //MARK: Event
        
        
    }

}

