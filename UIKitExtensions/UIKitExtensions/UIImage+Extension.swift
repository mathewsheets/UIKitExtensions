//
//  UIImage+Extensions.swift
//  ImageOperators
//
//  Created by Mathew Sheets on 4/21/16.
//  Copyright © 2016 Mathew Sheets. All rights reserved.
//

import UIKit

public extension UIImage {
    
    enum Direction {
        case horizontal
        case vertical
    }
    
    convenience init(direction: Direction, images: [UIImage]) {
        
        var image: UIImage
        
        switch direction {
        case .horizontal:
            image = UIImage.combineHorizontally(images)
        case .vertical:
            image = UIImage.combineVertically(images)
        }
        
        self.init(cgImage: image.cgImage!, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
    }
    
    convenience init(direction: Direction, image: UIImage, percentage: Float, mirrored: Bool = false) {
        
        var newImage: UIImage
        
        var orientation: UIImage.Orientation!
        switch direction {
        case .horizontal:
            newImage = UIImage.cropHorizontally(image, percentage: percentage, mirrored: mirrored)
            orientation = mirrored ? .upMirrored : .up
        case .vertical:
            newImage = UIImage.cropVertically(image, percentage: percentage, mirrored: mirrored)
            orientation = mirrored ? .down : .up
        }
        
        self.init(cgImage: newImage.cgImage!, scale: UIScreen.main.scale, orientation: orientation)
    }
    
    func flip(_ direction: Direction) -> UIImage {
        
        return UIImage(cgImage: self.cgImage!, scale: UIScreen.main.scale, orientation: direction == .horizontal ? .upMirrored : .down)
    }
    
    static func cropHorizontally(_ image: UIImage, percentage: Float, mirrored: Bool = false) -> UIImage {
        
        var goodPercentage = percentage
        if percentage <= 0.0 {
            goodPercentage = 0.000000000000001
        } else if percentage >= 1.0 {
            goodPercentage = 0.999999999999999
        }
        
        let newImageSize = CGSize(width: image.size.width * CGFloat(goodPercentage), height: image.size.height)
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        image.draw(at: CGPoint(x: 0, y: 0))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if mirrored {
            return UIImage(cgImage: newImage!.cgImage!, scale: UIScreen.main.scale, orientation: .upMirrored)
        }
        
        return newImage!
    }
    
    static func combineHorizontally(_ images: [UIImage]) -> UIImage {
        
        var width = CGFloat(0)
        for image in images {
            width += image.size.width
        }
        let height = images[0].size.height
        
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        var offset = CGFloat(0)
        for image in images {
            
            let width = image.size.width
            image.draw(in: CGRect(x: offset, y: 0, width: width, height: height))
            offset += width
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    static func cropVertically(_ image: UIImage, percentage: Float, mirrored: Bool = false) -> UIImage {
        
        var goodPercentage = percentage
        if percentage <= 0.0 {
            goodPercentage = 0.000000000000001
        } else if percentage >= 1.0 {
            goodPercentage = 0.999999999999999
        }
        
        let newImageSize = CGSize(width: image.size.width, height: image.size.height * CGFloat(goodPercentage))
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        image.draw(at: CGPoint(x: 0, y: 0))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if mirrored {
            return UIImage(cgImage: newImage!.cgImage!, scale: UIScreen.main.scale, orientation: .down)
        }
        
        return newImage!
    }
    
    static func combineVertically(_ images: [UIImage]) -> UIImage {

        let width = images[0].size.width
        var height = CGFloat(0)
        for image in images {
            height += image.size.height
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)

        var offset = CGFloat(0)
        for image in images {

            let height = image.size.height
            image.draw(in: CGRect(x: 0, y: offset, width: width, height: height))
            offset += height
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

precedencegroup CropPrecedence {
    associativity: left
}
precedencegroup CombinePrecedence {
    associativity: left
    higherThan: CropPrecedence
}

// image -* 0.5 = crop image horizontally 50%
infix operator -* : CropPrecedence
public func -* (left: UIImage, right: Float) -> UIImage {
    
    return UIImage(direction: .horizontal, image: left, percentage: right)
}

// image -*~ 0.5 = crop image horizontally 50% then mirror
infix operator -*~ : CropPrecedence
public func -*~ (left: UIImage, right: Float) -> UIImage {
    
    return UIImage(direction: .horizontal, image: left, percentage: right, mirrored: true)
}

// image |* 0.5 = crop image vertically 50%
infix operator |* : CropPrecedence
public func |* (left: UIImage, right: Float) -> UIImage {
    
    return UIImage(direction: .vertical, image: left, percentage: right)
}

// image |*~ 0.5 = crop image vertically 50% then mirror
infix operator |*~ : CropPrecedence
public func |*~ (left: UIImage, right: Float) -> UIImage {
    
    return UIImage(direction: .vertical, image: left, percentage: right, mirrored: true)
}

// (image <- image) <- image = combine two images horizontally
infix operator <- : CombinePrecedence
public func <- (left: UIImage, right: UIImage) -> UIImage {
    
    return UIImage(direction: .horizontal, images: [left, right])
}

// (image ^- image) ^- image = combine two images vertically
infix operator ^- : CombinePrecedence
public func ^- (left: UIImage, right: UIImage) -> UIImage {
    
    return UIImage(direction: .vertical, images: [left, right])
}
