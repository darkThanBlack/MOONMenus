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
    var vid: String? { get }
    
}

class CorrectingVoiceCell: CorrectingCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectingVoiceCellDelegate?
    func bindCell(delegate: CorrectingVoiceCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingVoiceCellDataSource) {
        super.configCell(dataSource: dataSource)
        
        voiceView.text = dataSource.vid
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingVoice(box: workView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectingVoice(box: UIView) {
        box.addSubview(voiceView)
        
        loadConstraintsForCorrectingVoice(box: box)
    }
    
    private func loadConstraintsForCorrectingVoice(box: UIView) {
        voiceView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(50.0)
        }
    }
    
    private lazy var voiceView: UILabel = {
        let voiceView = UILabel()
        voiceView.backgroundColor = CorrectingHelper.orange()
        voiceView.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        voiceView.textColor = CorrectingHelper.blackText()
        voiceView.text = " "
        return voiceView
    }()

}

