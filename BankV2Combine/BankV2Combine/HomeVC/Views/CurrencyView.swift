//
//  CurrencyView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class CurrencyView: UIView, SkeletonLoadable {
    private let title: String
    
    private lazy var label: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(ofSize: 16), textColor: ThemeColor.header, textAlignment: .left)
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: bounds.width * 1/2, height: 20))
        textField.textColor = ThemeColor.text
        textField.font = ThemeFont.demibold(ofSize: 24)
        textField.text = "$12312354"
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            label,
            textField
        ])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var textFieldLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        textField.layer.addSublayer(layer)
        return layer
    }()
    
    init(frame: CGRect, currency: String) {
        self.title = currency
        super.init(frame: frame)
        layout()
        setupAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textFieldLayer.frame = textField.bounds
        textFieldLayer.cornerRadius = textField.bounds.height / 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func setupAnimation() {
        let group = makeAnimationGroup()
        group.beginTime = 0.0
        textFieldLayer.add(group, forKey: "backgroundColor")
    }
    
    func stopAnimation() {
        textFieldLayer.removeAllAnimations()
    }
    
    func toggleSecurity() {
        textField.isSecureTextEntry.toggle()
    }
    
    func setTextFieldText(text: String) {
        textField.text = text
    }
}
