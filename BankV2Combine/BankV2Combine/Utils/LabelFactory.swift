//
//  LabelFactory.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

struct LabelFactory {
    
    static func build(text: String?,
                      font: UIFont,
                      backgroundColor: UIColor = .clear,
                      textColor: UIColor = ThemeColor.text,
                      textAlignment: NSTextAlignment = .center) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
