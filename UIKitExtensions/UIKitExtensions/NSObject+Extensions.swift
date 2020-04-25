//
//  NSObjectExtensions.swift
//  LiftOff
//
//  Created by Sheets on 4/23/20.
//  Copyright © 2020 Sheets. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        
        return String(describing: type(of: self))
    }
    
    class var className: String {
        
        return String(describing: self)
    }
}
