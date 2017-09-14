//
//  UIView+Extensions.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import UIKit

public extension UIView {
    
    public convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
    }
    
    public func asImage() -> UIImage {
        
        UIGraphicsBeginImageContext(bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        layer.render(in: currentContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
