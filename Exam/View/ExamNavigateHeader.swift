//
//  ExamNavigateHeader.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/7.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

protocol ExamNavigateHeaderDataSource {
    var title: String? { get }
    var totalCount: Int { get }
}

class ExamNavigateHeader: UICollectionReusableView {
    
    //MARK: Interface
    
    func configView(dataSource: ExamNavigateHeaderDataSource) {
        titleLabel.text = dataSource.title
        countLabel.isHidden = !(dataSource.totalCount > 0)
        countLabel.text = "共\(dataSource.totalCount)题"
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForExamNavigateHeader(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamNavigateHeader(box: UIView) {
        box.addSubview(titleLabel)
        box.addSubview(countLabel)
        
        loadConstraintsForExamNavigateHeader(box: box)
    }
    
    private func loadConstraintsForExamNavigateHeader(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-12.0)
            
            make.right.lessThanOrEqualTo(countLabel.snp.left).offset(-16.0)
        }
        countLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.right.equalTo(box.snp.right).offset(-16.0)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        titleLabel.textColor = ExamHelper.blackText()
        titleLabel.text = " "
        return titleLabel
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        countLabel.textColor = ExamHelper.lightGrayText()
        countLabel.text = " "
        countLabel.textAlignment = .right
        return countLabel
    }()


}
