//
//  UIColorExtension.swift
//  Youth-App
//
//  Created by Thuan Tran on 3/30/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
