//
//  CorrectingHelper.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class CorrectingHelper {
    //https://my.oschina.net/kevinvane/blog/473640
    static func xm_color(hex: Int64, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
    static func blackText() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x333333)
    }
    static func grayText() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x666666)
    }
    static func lightGrayText() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x999999)
    }
    static func blueText() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x0076FF)
    }
    static func blue() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x58B7EF)
    }
    static func orange() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0xFFAB1A)
    }
    static func red() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0xFF4F4F)
    }
    static func grayLayer() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0xBFBFBF)
    }
    static func singleLine() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0x747474)
    }
    static func background() -> UIColor {
        return CorrectingHelper.xm_color(hex: 0xFAFAFA)
    }
}
