//
//  Animations.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

extension UILabel {
    
    func animateTitle() {
        guard let oldText = text else { return }
        text = ""
        var charIndex = 0.0
        for letter in oldText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {[weak self] _ in
                self?.text?.append(letter)
            }
            charIndex += 1
        }
    }
}

extension UIImageView {
    
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(shakeAnimation, forKey: "position")

    }
}

