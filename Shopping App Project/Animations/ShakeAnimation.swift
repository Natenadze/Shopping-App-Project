//
//  ShakeAnimation.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 26.01.23.
//

import UIKit


struct ShakeAnimation {
    
    static func shake(view: UIImageView) {
        
            let animation = CAKeyframeAnimation()
            animation.keyPath = "position.x"
            animation.values = [0, 10, -10, 10, 0]
            animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
            animation.duration = 0.4
            animation.isAdditive = true
        view.layer.add(animation, forKey: "shake")
        UIView.animate(withDuration: 2, delay: 0) {
            view.transform = .identity
        }
    }
}
