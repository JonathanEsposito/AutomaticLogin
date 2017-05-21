//
//  UIButtonExtentions.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var topInset: CGFloat {
        set {
            self.contentEdgeInsets = UIEdgeInsetsMake(newValue, self.contentEdgeInsets.left, self.contentEdgeInsets.bottom, self.contentEdgeInsets.right)
        }
        get {
            return self.contentEdgeInsets.top
        }
    }
    
    @IBInspectable var bottmInset: CGFloat {
        set {
            self.contentEdgeInsets = UIEdgeInsetsMake(self.contentEdgeInsets.top, self.contentEdgeInsets.left, newValue, self.contentEdgeInsets.right)
        }
        get {
            return self.contentEdgeInsets.bottom
        }
    }
    
    @IBInspectable var leftInset: CGFloat {
        set {
            self.contentEdgeInsets = UIEdgeInsetsMake(self.contentEdgeInsets.top, newValue, self.contentEdgeInsets.bottom, self.contentEdgeInsets.right)
        }
        get {
            return self.contentEdgeInsets.left
        }
    }
    
    @IBInspectable var rightInset: CGFloat {
        set {
            self.contentEdgeInsets = UIEdgeInsetsMake(self.contentEdgeInsets.top, self.contentEdgeInsets.left, self.contentEdgeInsets.bottom, newValue)
        }
        get {
            return self.contentEdgeInsets.right
        }
    }
    
    @IBInspectable var highlightedBackgroundColor:UIColor? {
        set {
            setBackgroundColor(newValue!, for: .highlighted)
        }
        get {
            if let backgroundColor = self.backgroundImage(for: .highlighted) {
                return backgroundColor.getPixelColor(pos: CGPoint(x: 1, y: 1))
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable var normalBackgroundColor:UIColor? {
        set {
            setBackgroundColor(newValue!, for: .normal)
        }
        get {
            if let backgroundColor = self.backgroundImage(for: .normal) {
                return backgroundColor.getPixelColor(pos: CGPoint(x: 1, y: 1))
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable var adjustFontSize: Bool {
        get {
            return titleLabel?.numberOfLines == 1 && titleLabel?.adjustsFontSizeToFitWidth == true && titleLabel?.lineBreakMode == .byClipping
        }
        set {
            if newValue {
                titleLabel?.numberOfLines = 1
                titleLabel?.adjustsFontSizeToFitWidth = true
                titleLabel?.lineBreakMode = .byClipping //<-- MAGIC LINE
                contentEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
            } else {
                titleLabel?.numberOfLines = 1
                titleLabel?.adjustsFontSizeToFitWidth = false
                titleLabel?.lineBreakMode = .byTruncatingTail
                contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
}

extension UIButton {
    private func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color), for: state)
    }
}
