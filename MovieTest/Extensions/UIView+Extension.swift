//
//  UIView+Extension.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
}
