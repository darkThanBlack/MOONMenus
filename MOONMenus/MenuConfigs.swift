//
//  MenuConfigs.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

enum MenuState {
    case isOpen
    case isClose
}

enum AbsorbMode {
    case system
    case edge
    case none
}

class MenuConfigs {
        
    var state = MenuState.isClose
    var absorb = AbsorbMode.system
    
    private let openSize = CGSize(width: 300.0, height: 300.0)
    private let closeSize = CGSize(width: 65.0, height: 65.0)
    
    func updateMenuState(newState: MenuState) -> Bool {
        let success = (state != newState)
        if success {
            state = newState
        }
        return success
    }
    
    func updateMenuPosition(center: CGPoint) -> Bool {
        let success = (state == .isClose)
        if success {
            UserDefaults.standard.set(NSCoder.string(for: center), forKey: "kMOONMenuCenter")
            UserDefaults.standard.synchronize()
        }
        return success
    }
    
    func queryMenuFrame() -> CGRect {
        let defCenter = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height * 0.33)
        switch state {
        case .isOpen:
            return CGRect(x: defCenter.x - openSize.width / 2.0, y: defCenter.y - openSize.height / 2.0, width: openSize.width, height: openSize.height)
        case .isClose:
            let value: String? = UserDefaults.standard.object(forKey: "kMOONMenuCenter") as? String
            var center = defCenter
            if value != nil {
                center = NSCoder.cgPoint(for: value!)
            }
            return CGRect(x: center.x - closeSize.width / 2.0, y: center.y - closeSize.height / 2.0, width: closeSize.width, height: closeSize.height)
        }
    }
}
