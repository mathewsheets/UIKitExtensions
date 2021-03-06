//
//  UIImageView+Extensions.swift
//  UIKitExtensions
//
//  Created by Sheets on 9/13/17.
//  Copyright © 2017 Sheets. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    convenience init(_ f: CGRect, _ image: UIImage) {
        
        self.init(frame: f)
        self.image = image
    }
    
    func circle() {
        
        self.layer.cornerRadius = self.bounds.height / 2.0
        self.clipsToBounds = true;
    }
}
