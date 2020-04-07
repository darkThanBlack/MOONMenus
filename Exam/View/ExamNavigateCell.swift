//
//  ExamNavigateCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/7.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

protocol ExamNavigateCellDataSource {
    var isSelected: Bool { get }
    var title: String? { get }
    var star: Int64? { get }
}

///测评模块详情 - 第X题
class ExamNavigateCell {
    
    ///单文字
    class Single: UICollectionViewCell {
        
        //MARK: Interface
        
        func configCell(dataSource: ExamNavigateCellDataSource) {
            if dataSource.isSelected {
                contentView.layer.borderColor = ExamHelper.heavyOrange().cgColor
                titleLabel.textColor = ExamHelper.heavyOrange()
            } else {
                contentView.layer.borderColor = ExamHelper.grayBorder().cgColor
                titleLabel.textColor = ExamHelper.lightGrayText()
            }
            titleLabel.text = dataSource.title ?? " "
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForExamNavigate(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForExamNavigate(box: UIView) {
            box.addSubview(titleLabel)
            
            box.layer.masksToBounds = true
            box.layer.cornerRadius = 5.0
            box.layer.borderWidth = 1.0
            
            loadConstraintsForExamNavigate(box: box)
        }
        
        private func loadConstraintsForExamNavigate(box: UIView) {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.width.equalTo(78.0)
                make.height.equalTo(38.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = ExamHelper.lightGrayText()
            titleLabel.text = " "
            titleLabel.textAlignment = .center
            return titleLabel
        }()
        
    }
    
    ///带星星
    class Star: UICollectionViewCell {
        
        //MARK: Interface
        
        func configCell(dataSource: ExamNavigateCellDataSource) {
            if dataSource.isSelected {
                contentView.layer.borderColor = ExamHelper.heavyOrange().cgColor
                titleLabel.textColor = ExamHelper.heavyOrange()
            } else {
                contentView.layer.borderColor = ExamHelper.grayBorder().cgColor
                titleLabel.textColor = ExamHelper.lightGrayText()
            }
            titleLabel.text = dataSource.title ?? " "
            star.configStar(count: dataSource.star ?? 0)
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForExamNavigate(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
    ///https://stackoverflow.com/questions/25895311/uicollectionview-self-sizing-cells-with-auto-layout
//        var isHeightCalculated: Bool = false
//        override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//            if !isHeightCalculated {
//                setNeedsLayout()
//                layoutIfNeeded()
//                let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//                var newFrame = layoutAttributes.frame
//                newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//                layoutAttributes.frame = newFrame
//                isHeightCalculated = true
//            }
//            return layoutAttributes
//        }
        
        private func loadViewsForExamNavigate(box: UIView) {
            box.addSubview(titleLabel)
            box.addSubview(star)
            
            box.layer.masksToBounds = true
            box.layer.cornerRadius = 5.0
            box.layer.borderWidth = 1.0
            
            loadConstraintsForExamNavigate(box: box)
        }
        
        private func loadConstraintsForExamNavigate(box: UIView) {
            
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(box.snp.centerX)
                make.top.equalTo(box.snp.top).offset(8.0)
            }
            star.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(2.0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0).priority(.low)
                make.bottom.equalTo(box.snp.bottom).offset(-8.0).priority(.low)
                make.height.equalTo(12.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = ExamHelper.lightGrayText()
            titleLabel.text = " "
            titleLabel.textAlignment = .center
            return titleLabel
        }()
        
        private lazy var star: ExamStar = {
            let star = ExamStar(maxCount: 3, style: .small)
            return star
        }()
    }
}
