//
//  CorrectingVoiceCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingVoiceCell 用户事件
protocol CorrectingVoiceCellDelegate: class {
    func CorrectingVoiceCellEvent()
}

///CorrectingVoiceCell 数据源
protocol CorrectingVoiceCellDataSource: CorrectingCellDataSource {
    
}

class CorrectingVoiceCell: CorrectingCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectingVoiceCellDelegate?
    func bindCell(delegate: CorrectingVoiceCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingVoiceCellDataSource) {
        super.configCell(dataSource: dataSource)
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingVoice(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingVoice(box: UIView) {
        
        
        loadConstraintsForCorrectingVoice(box: box)
    }
    
    private func loadConstraintsForCorrectingVoice(box: UIView) {
        
    }
    
    //MARK: Event
    
}

