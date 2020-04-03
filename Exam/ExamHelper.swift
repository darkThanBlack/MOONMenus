//
//  ExamHelper.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/3.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ExamHelper {
    //https://my.oschina.net/kevinvane/blog/473640
    static func xm_color(hex: Int64, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
    static func blackText() -> UIColor {
        return ExamHelper.xm_color(hex: 0x333333)
    }
    static func grayText() -> UIColor {
        return ExamHelper.xm_color(hex: 0x666666)
    }
    static func lightGrayText() -> UIColor {
        return ExamHelper.xm_color(hex: 0x999999)
    }
    static func orange() -> UIColor {
        return ExamHelper.xm_color(hex: 0xFFAB1A)
    }
    static func green() -> UIColor {
        return ExamHelper.xm_color(hex: 0x3BBDAA)
    }
    static func red() -> UIColor {
        return ExamHelper.xm_color(hex: 0xFF4F4F)
    }
    static func grayBorder() -> UIColor {
        return ExamHelper.xm_color(hex: 0xEEEEEE)
    }
}
