//
//  BalanceView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class BalanceView: UIView {
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "My Account Balance", font: ThemeFont.demibold(ofSize: 18), textColor: ThemeColor.header, textAlignment: .left)
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(toggleBalanceView), for: .touchUpInside)
        button.tintColor = ThemeColor.primary
        return button
    }()
        
    private let usdView = CurrencyView(currency: "USD")
    private let khrView = CurrencyView(currency: "KHR")
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            
            usdView,
            khrView
        ])
        view.axis = .vertical
        view.distribution = .fillEqually
        
        return view
    }()
    
    @objc private func toggleBalanceView(_ sender: Any) {
        usdView.toggleSecurity()
        khrView.toggleSecurity()
        eyeButton.isSelected.toggle()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerLabel, eyeButton, vStackView].forEach(addSubview(_:))
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            
            eyeButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: headerLabel.trailingAnchor, multiplier: 1),
            
            vStackView.topAnchor.constraint(equalToSystemSpacingBelow: headerLabel.bottomAnchor, multiplier: 1),
            vStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: vStackView.trailingAnchor, multiplier: 2),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }
}


