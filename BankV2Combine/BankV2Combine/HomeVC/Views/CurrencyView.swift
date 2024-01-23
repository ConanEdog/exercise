//
//  CurrencyView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class CurrencyView: UIView {
    private let title: String
    
    private lazy var label: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(ofSize: 16), textColor: ThemeColor.header, textAlignment: .left)
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
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
    init(currency: String) {
        self.title = currency
        
        super.init(frame: .zero)
        
        layout()
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
    
    func toggleSecurity() {
        textField.isSecureTextEntry.toggle()
    }
}
