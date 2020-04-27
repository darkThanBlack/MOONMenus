//
//  MOONMenuHelper.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/27.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class MOONMenuHelper {
    
    static func queryImage(named: String) -> UIImage? {
        guard let bundleUrl = Bundle.main.url(forResource: "MOONMenuSkin", withExtension: "bundle") else {
            return UIImage(named: named)
        }
        guard let bundle = Bundle(url: bundleUrl) else {
            return UIImage(named: named)
        }
        return UIImage(named: named, in: bundle, with: nil)
    }
    
}
