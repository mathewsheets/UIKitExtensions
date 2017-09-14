//
//  CGRect+Extension.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import UIKit

public extension CGRect {
    
    public init(_ size: CGSize) {
        
        self.init(origin: CGPoint(), size: size)
    }
}
