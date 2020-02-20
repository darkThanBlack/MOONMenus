//
//  SubMenuView.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SubMenuView: BasicMenuDelegate {
    
    func basicMenuStateWillChange(state: MenuState) {
        
    }
}

class MoonStyleMenu: SubMenuView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForMoonStyleMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadViewsForMoonStyleMenu() {
        
    }
}
