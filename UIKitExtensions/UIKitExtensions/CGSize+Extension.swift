//
//  CGSize+Extension.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import Foundation

public extension CGSize {
    
    init(_ w: CGFloat) {
        
        self.init(width: w, height: w)
    }
    
    init(_ w: CGFloat, _ h: CGFloat) {
        
        self.init(width: w, height: h)
    }

}
