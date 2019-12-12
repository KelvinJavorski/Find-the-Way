//
//  UIViewExtension.swift
//  MyBookcase
//
//  Created by Kaz Born on 26/05/19.
//  Copyright © 2019 Kaz Born. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
//    var corners : CACornerMask = CACornerMask()
    
    @IBInspectable public var cornerRadius : CGFloat = 0 {
		didSet {
			self.updateCorners()
		}
    }
    /*
    @IBInspectable public var topLeft : Bool = true {
		didSet {
			if topLeft {
				corners.insert(.layerMinXMinYCorner)
			} else {
				if corners.contains(.layerMinXMinYCorner) {
					corners.remove(.layerMinXMinYCorner)
				}
			}
			self.updateCorners()
		}
    }
    
    @IBInspectable public var topRight : Bool = true {
		didSet {
			if topRight {
				corners.insert(.layerMaxXMinYCorner)
			} else {
				if corners.contains(.layerMaxXMinYCorner) {
					corners.remove(.layerMaxXMinYCorner)
				}
			}
			self.updateCorners()
		}
    }
    
    @IBInspectable public var bottomLeft : Bool = true {
		didSet {
			if bottomLeft {
				corners.insert(.layerMinXMaxYCorner)
			} else {
				if corners.contains(.layerMinXMaxYCorner) {
					corners.remove(.layerMinXMaxYCorner)
				}
			}
			self.updateCorners()
		}
    }
    
	@IBInspectable public var bottomRight : Bool = true {
		didSet {
			if bottomRight {
				corners.insert(.layerMaxXMaxYCorner)
			} else {
				if corners.contains(.layerMaxXMaxYCorner) {
					corners.remove(.layerMaxXMaxYCorner)
				}
			}
			self.updateCorners()
		}
	}
    */
    func updateCorners() {
        self.layer.cornerRadius = cornerRadius
//        self.layer.maskedCorners = corners
    }
    
}

public extension UIView {
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
    
}
