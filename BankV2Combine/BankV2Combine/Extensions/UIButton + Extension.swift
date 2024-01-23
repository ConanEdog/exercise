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
    
    func largeVerticalSet(title: String, imageName: String, fontSize:CGFloat, imageSize: CGFloat, fontWeight: UIFont.Weight) {
        let config = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .top
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = .systemGray2
        
    }
}
