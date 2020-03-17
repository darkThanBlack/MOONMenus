//
//  LessonHelper.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

struct LessonHelper {
    
    //https://my.oschina.net/kevinvane/blog/473640
    static func xm_color(hex: Int64, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
    static func blackText() -> UIColor {
        return LessonHelper.xm_color(hex: 0x333333)
    }
    static func grayText() -> UIColor {
        return LessonHelper.xm_color(hex: 0x666666)
    }
    static func lightGrayText() -> UIColor {
        return LessonHelper.xm_color(hex: 0x999999)
    }
    static func blueText() -> UIColor {
        return LessonHelper.xm_color(hex: 0x0076FF)
    }
    static func blue() -> UIColor {
        return LessonHelper.xm_color(hex: 0x58B7EF)
    }
    static func orange() -> UIColor {
        return LessonHelper.xm_color(hex: 0xFFAB1A)
    }
    static func red() -> UIColor {
        return LessonHelper.xm_color(hex: 0xFF4F4F)
    }
    static func grayLayer() -> UIColor {
        return LessonHelper.xm_color(hex: 0xBFBFBF)
    }
    static func singleLine() -> UIColor {
        return LessonHelper.xm_color(hex: 0x747474)
    }
    static func background() -> UIColor {
        return LessonHelper.xm_color(hex: 0xFAFAFA)
    }
}

////https://my.oschina.net/kevinvane/blog/473640
//+ (UIColor *)vs_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
//{
//    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
//                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
//                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
//}
//
//+ (UIColor *)dynamicDefaultColor:(UIColor *)color1 darkColor:(UIColor *)color2
//{
//    if (@available(iOS 13.0, *)) {
//        UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//                return color2;
//            } else {
//                return color1;
//            }
//        }];
//        return dynamicColor;
//    }
//    return color1;
//}
