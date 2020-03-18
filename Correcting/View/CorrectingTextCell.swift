//
//  CorrectingTextCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

protocol CustomCellType: UITableViewCell {
    associatedtype DataSource
    func configCell(data: DataSource)
}
///CorrectingTextCell 数据源
protocol CorrectingTextCellDataSource: CorrectingCellDataSource {
    var text: String? { get }
}

class CorrectingTextCell: CorrectingCell {
    
    //MARK: Interface
        
    func configCell(dataSource: CorrectingTextCellDataSource) {
        super.configCell(dataSource: dataSource)
        
        workLabel.text = dataSource.text ?? " "
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingText(box: workView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingText(box: UIView) {
        box.addSubview(workLabel)
        
        loadConstraintsForCorrectingText(box: box)
    }
    
    private func loadConstraintsForCorrectingText(box: UIView) {
        workLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0.0)
            make.left.equalTo(box.snp.left).offset(0.0)
            make.right.equalTo(box.snp.right).offset(-0.0)
            make.bottom.equalTo(box.snp.bottom).offset(-0.0)
        }
    }
    
    private lazy var workLabel: UILabel = {
        let workLabel = UILabel()
        workLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        workLabel.textColor = CorrectingHelper.blackText()
        workLabel.text = " "
        workLabel.numberOfLines = 0
        return workLabel
    }()
    
    //MARK: Event
    
}

