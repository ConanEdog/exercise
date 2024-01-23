//
//  UIButton+Extension.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

extension UIButton {
    
    func verticalSet(title: String, imageName: String, pointSize: CGFloat) {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .top
//        btnConfig.titleLineBreakMode = .byTruncatingTail
        var container = AttributeContainer()
        container.font = ThemeFont.demibold(ofSize: 12)
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
        container.font = ThemeFont.regular(ofSize: fontSize)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = .systemGray2
        
    }
    
    func rightImage(title: String, imageName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .trailing
        
        var container = AttributeContainer()
        container.font = ThemeFont.regular(ofSize: 16)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(systemName: imageName, withConfiguration: config)
        btnConfig.imagePadding = 2
        self.configuration = btnConfig
        self.tintColor = .systemGray2
        
    }
}
