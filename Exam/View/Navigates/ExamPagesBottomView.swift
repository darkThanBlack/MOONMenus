//
//  ExamPagesBottomView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/8.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///答题记录/测评模块详情 - 底部 上一题/下一题
class ExamPagesBottomView: UIView {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForExamPagesBottom(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamPagesBottom(box: UIView) {
        
        
        loadConstraintsForExamPagesBottom(box: box)
    }
    
    private func loadConstraintsForExamPagesBottom(box: UIView) {
        
    }
    
    
    
    //MARK: Event
    
    
}

