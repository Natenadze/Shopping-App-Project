//
//  ShakeAnimation.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 26.01.23.
//

import UIKit


struct ShakeAnimation {
    
    static func shake(imageView: UIImageView) {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: imageView.center.x - 5, y: imageView.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: imageView.center.x + 5, y: imageView.center.y))
        imageView.layer.add(shakeAnimation, forKey: "position")

    }
}
