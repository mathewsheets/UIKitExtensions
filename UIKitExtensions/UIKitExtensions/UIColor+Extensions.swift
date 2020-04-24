//
//  UIColor+Extension.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    func hexDescription(_ includeAlpha: Bool = false) -> String {
        if self.cgColor.numberOfComponents == 4 {
            let components = self.cgColor.components
            let red = Float((components?[0])!) * 255.0
            let green = Float((components?[1])!) * 255.0
            let blue = Float((components?[2])!) * 255.0
            let alpha = Float((components?[3])!) * 255.0
            if (includeAlpha) {
                return String.init(format: "%02x%02x%02x%02x", Int(red), Int(green), Int(blue), Int(alpha))
            } else {
                return String.init(format: "%02x%02x%02x", Int(red), Int(green), Int(blue))
            }
        } else {
            return "Color not RGB."
        }
    }
    
    func lighter(_ amount : CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightness(1 + amount)
    }
    
    func darker(_ amount : CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightness(1 - amount)
    }
    
    fileprivate func hueColorWithBrightness(_ amount: CGFloat) -> UIColor {
        var hue         : CGFloat = 0
        var saturation  : CGFloat = 0
        var brightness  : CGFloat = 0
        var alpha       : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * amount, alpha: alpha )
        } else {
            print("return the same color")
            return self
        }
    }
    
}
