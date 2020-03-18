//
//  CorrectingImageCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingImageCell 用户事件
protocol CorrectingImageCellDelegate: class {
    func CorrectingImageCellEvent()
}

///CorrectingImageCell 数据源
protocol CorrectingImageCellDataSource: CorrectingCellDataSource {
    
}

class CorrectingImageCell: CorrectingCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectingImageCellDelegate?
    func bindCell(delegate: CorrectingImageCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingImageCellDataSource) {
        super.configCell(dataSource: dataSource)
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingImage(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingImage(box: UIView) {
        
        
        loadConstraintsForCorrectingImage(box: box)
    }
    
    private func loadConstraintsForCorrectingImage(box: UIView) {
        
    }
    
    //MARK: Event
    
}

