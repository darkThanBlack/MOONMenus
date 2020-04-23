//
//  SubMenuView.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubMenuView: UIView {
    
    var items: [MenuItem] = []
    
    func updateMenuItems(items: [MenuItem]) {
        for item in self.items {
            item.removeFromSuperview()
        }
        self.items.removeAll()
        
        self.items = items
        for item in self.items {
            self.addSubview(item)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -

class MoonStyleMenu: SubMenuView {
    
    override func updateMenuItems(items: [MenuItem]) {
        super.updateMenuItems(items: items)
        
        
    }
    
    private lazy var visualView: UIVisualEffectView = {
        var effect: UIVisualEffect
        if #available(iOS 13.0, *) {
            effect = UIBlurEffect(style: .systemMaterial)
        } else {
            effect = UIBlurEffect(style: .extraLight)
        }
        let visualView = UIVisualEffectView(effect: effect)
        return visualView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForMoonStyleMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadViewsForMoonStyleMenu() {
        self.addSubview(visualView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        visualView.frame = self.bounds
        
        for (index, item) in items.enumerated() {
            
        }
    }
    
    
}
