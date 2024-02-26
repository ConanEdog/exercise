//
//  FavoriteCollectionViewCell.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    var button = UIButton(type: .custom)
    static let reusedId = "favoriteCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(button)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(item: Item) {
        button.largeVerticalSet(title: item.nickname, imageName: item.transType.rawValue, fontSize: 12, imageSize: 48, fontWeight: .regular)
    }
}
