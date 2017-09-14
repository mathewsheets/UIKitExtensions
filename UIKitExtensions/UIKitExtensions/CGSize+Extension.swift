//
//  CGSize+Extension.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import UIKit

public extension CGSize {
    
    public init(_ w: CGFloat) {
        
        self.init(width: w, height: w)
    }
    
    public init(_ w: CGFloat, _ h: CGFloat) {
        
        self.init(width: w, height: h)
    }
}
