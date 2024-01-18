//
//  UIButton+Utils.swift
//  PasswordCombine
//
//  Created by 方奎元 on 2024/1/18.
//

import UIKit

extension UIButton {
    
    func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        self.layer.add(animation, forKey: "shake")
    }
}
