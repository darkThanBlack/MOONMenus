//
//  ExamStar.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/7.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///星星，布局时要放死高度
class ExamStar: UIView {
    
    //MARK: Interface
            
    func configStar(count: Int64) {
        for (index, star) in starArray.enumerated() {
            star.image = index < count ? UIImage(named: "moonShadow") : nil
        }
    }
    
    private var starArray: [UIImageView] = []
    
    //MARK: Life Cycle
    
    enum Style {
        case big
        case middle
        case small
    }
    
    required init(maxCount: Int, style: Style) {
        super.init(frame: .zero)
        
        loadViewsForStar(box: self, maxCount: maxCount, style: style)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForStar(box: UIView, maxCount: Int, style: Style) {
        
        starArray.removeAll()
        for _ in 0..<maxCount {
            let star = UIImageView()
            star.backgroundColor = ExamHelper.lightGrayText()
            box.addSubview(star)
            starArray.append(star)
        }
        
        loadConstraintsForStar(box: box, style: style)
    }
    
    private func loadConstraintsForStar(box: UIView, style: Style) {
        var gap = 0.0
        switch style {
        case .big:
            gap = 14.0
        case .middle:
            gap = 8.0
        case .small:
            gap = 4.0
        }
        
        var tmpView = UIView()
        for (index, star) in starArray.enumerated() {
            if index == 0 {
                star.snp.makeConstraints { (make) in
                    make.top.equalTo(box.snp.top).offset(0)
                    make.left.equalTo(box.snp.left).offset(0)
                    make.bottom.equalTo(box.snp.bottom).offset(-0)
                    make.width.equalTo(star.snp.height)
                }
            } else if index == (starArray.count - 1) {
                star.snp.makeConstraints { (make) in
                    make.centerY.equalTo(tmpView.snp.centerY)
                    make.left.equalTo(tmpView.snp.right).offset(gap)
                    make.right.equalTo(box.snp.right).offset(-0)
                    make.width.equalTo(tmpView)
                    make.height.equalTo(tmpView)
                }
            } else {
                star.snp.makeConstraints { (make) in
                    make.centerY.equalTo(tmpView.snp.centerY)
                    make.left.equalTo(tmpView.snp.right).offset(gap)
                    make.width.equalTo(tmpView)
                    make.height.equalTo(tmpView)
                }
            }
            tmpView = star
        }
    }
    
    
}
