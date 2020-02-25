//
//  ItemConfigs.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/24.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ItemConfigs {
    
    typealias UserAction = () -> Void

    var image: UIImage?
    var title: String?
    var action: UserAction?
    
    func bindUserAction(action: @escaping UserAction) -> Void {
        self.action = action
    }
    
}
