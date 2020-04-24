//
//  UIViewController+Extensions.swift
//  UIKitExtensions
//
//  Created by Sheets on 4/24/20.
//  Copyright © 2020 Sheets. All rights reserved.
//

import UIKit

extension UIViewController {

    var isModal: Bool {

        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first != self { return false }
        }

        if self.presentingViewController != nil { return true }

        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  { return true }

        if self.tabBarController?.presentingViewController is UITabBarController { return true }

        return false
    }
}
