//
//  ClassEndHelper.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/5/4.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ClassEndHelper {
    
    //https://my.oschina.net/kevinvane/blog/473640
    static func xm_color(hex: Int64, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
    static func red() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0xFF4F4F)
    }
    static func heavyOrange() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0xFF8534)
    }
    static func blackText() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0x333333)
    }
    static func grayText() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0x666666)
    }
    static func lightGrayText() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0x999999)
    }
    static func grayLayer() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0xE8E8E8)
    }
    static func singleLine() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0xEEEEEE)
    }
    static func background() -> UIColor {
        return ClassEndHelper.xm_color(hex: 0xFAFAFA)
    }
}
