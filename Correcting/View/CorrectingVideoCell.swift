//
//  CorrectingVideoCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingVideoCell 用户事件
protocol CorrectingVideoCellDelegate: class {
    func CorrectingVideoCellEvent()
}

///CorrectingVideoCell 数据源
protocol CorrectingVideoCellDataSource: CorrectingCellDataSource {
    
}

class CorrectingVideoCell: CorrectingCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectingVideoCellDelegate?
    func bindCell(delegate: CorrectingVideoCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingVideoCellDataSource) {
        super.configCell(dataSource: dataSource)
        
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingVideo(box: workView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingVideo(box: UIView) {
        box.addSubview(videoView)
        
        loadConstraintsForCorrectingVideo(box: box)
    }
    
    private func loadConstraintsForCorrectingVideo(box: UIView) {
        
    }
    
    private lazy var videoView: UIView = {
        let videoView = UIView()
        videoView.backgroundColor = CorrectingHelper.orange()
        return videoView
    }()
    
    //MARK: Event
    
}

