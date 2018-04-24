//
//  ZCCPreHeader.swift
//  interviewForiOS
//
//  Created by 吴涛 on 2018/4/24.
//  Copyright © 2018年 wutao. All rights reserved.
//

import UIKit

let IFINavBgColor = colorWith255RGB(67,g:66,b:86)
let IFINavItemColor = UIColor(valueRGB:0xc4c4c4) /// nav item
func colorWith255RGB(_ r:CGFloat , g:CGFloat, b:CGFloat) ->UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
func colorWith255RGBA(_ r:CGFloat , g:CGFloat, b:CGFloat,a:CGFloat) ->UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

extension UIColor {
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
func createImageWithColor(_ color:UIColor) -> UIImage{
    return createImageWithColor(color, size: CGSize(width: 1, height: 1))
}
func createImageWithColor(_ color:UIColor,size:CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    context?.setFillColor(color.cgColor);
    context?.fill(rect);
    
    let theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage!;
}
