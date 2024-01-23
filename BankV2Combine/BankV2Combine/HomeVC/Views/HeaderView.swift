//
//  HeaderView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class HeaderView: UICollectionReusableView {

    private let titleLabel: UILabel = {
        LabelFactory.build(text: "My Favorite", font: ThemeFont.demibold(ofSize: 18), textColor: ThemeColor.header, textAlignment: .left)
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.rightImage(title: "More", imageName: "chevron.right")
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            UIView(),
            button
        ])
        return view
    }()
    
    static let reusedId = "headerView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor),
            hStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: hStackView.trailingAnchor, multiplier: 2)
        ])
    }
}
