//
//  LessonView.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonView: UIView {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForLesson(box: self)
        
        loadViewDebugMode(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadViewDebugMode(view: UIView) {
        for subView in view.subviews {
            subView.layer.borderWidth = 0.5
            subView.layer.borderColor = UIColor.green.cgColor
            self.loadViewDebugMode(view: subView)
        }
    }
    
    //MARK: View
    
    private func loadViewsForLesson(box: UIView) {
        box.addSubview(capacity)
        box.addSubview(slider)
        
        loadConstraintsForLesson(box: box)
    }
    
    private func loadConstraintsForLesson(box: UIView) {
        capacity.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(capacity.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(capacity.snp.width)
            make.height.equalTo(100)
        }
    }
    
    private lazy var capacity: CapacityAlertView = {
        let capacity = CapacityAlertView()
        capacity.backgroundColor = .white
        return capacity
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        return slider
    }()
    
    //MARK: Event
    
    @objc private func sliderAction(slider: UISlider) {
        capacity.process = CGFloat(slider.value)
        if slider.value == 1.0 {
            let alert = CapacityAlertController()
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}

