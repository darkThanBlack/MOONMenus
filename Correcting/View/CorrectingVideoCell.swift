//
//  CorrectingVideoCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingVideoCell 用户事件
protocol CorrectingVideoCellDelegate: CorrectingCellDelegate {
    func correctVideoEvent()
}

///CorrectingVideoCell 数据源
protocol CorrectingVideoCellDataSource: CorrectingCellDataSource {
    
}

class CorrectingVideoCell: CorrectingCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectingVideoCellDelegate?
    func bindCell(delegate: CorrectingVideoCellDelegate) {
        super.bindCell(delegate: delegate)
        
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
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(193.0)
        }
    }
    
    private lazy var videoView: UILabel = {
        let videoView = UILabel()
        videoView.backgroundColor = CorrectingHelper.orange()
        videoView.layer.cornerRadius = 5.0
        videoView.layer.masksToBounds = true
        videoView.textAlignment = .center
        videoView.text = "Student Videos..."
        
        videoView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(videoViewEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        videoView.addGestureRecognizer(singleTap)
        
        return videoView
    }()
    
    //MARK: Event

    @objc private func videoViewEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctVideoEvent()
    }

}

