//
//  UIButton+Extension.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

extension UIButton {
    
    func verticalSet(title: String, imageName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .top
//        btnConfig.titleLineBreakMode = .byTruncatingTail
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(systemName: imageName, withConfiguration: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        tintColor = .systemGray2
    }
}
