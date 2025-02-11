//
//  UIView+Extension.swift
//  Catstagram
//
//  Created by 김수비 on 1/16/25.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { // 모따기(모서리따기)
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

