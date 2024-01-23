//
//  BtnCollectionViewCell.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class BtnCollectionViewCell: UICollectionViewCell {
    
    var btn = UIButton(type: .custom)
    static let reusedId = "BtnCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(btn)
        
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(index: Int) {
        self.backgroundColor = ThemeColor.background
        switch index {
        case 0:
            btn.largeVerticalSet(title: "Transfer", imageName: "transfer" ,fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 1:
            btn.largeVerticalSet(title: "Payment", imageName: "payment",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 2:
            btn.largeVerticalSet(title: "Utility", imageName: "utility",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 3:
            btn.largeVerticalSet(title: "QR pay scan", imageName: "scan",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 4:
            btn.largeVerticalSet(title: "My QR code", imageName: "qrcode",fontSize: 14, imageSize: 56, fontWeight: .regular)
        case 5:
            btn.largeVerticalSet(title: "Top up", imageName: "topUp",fontSize: 14, imageSize: 56, fontWeight: .regular)
            
        default:
            break
            
        }
        
       
    }
    
    @objc func pressed(_ sender: UIButton) {
        print("btn \(sender.titleLabel?.text ?? "Non")")
//        if let collectionView = self.superview as? UICollectionView {
//            let index = collectionView.indexPathForCellContaining(view: self.btn)
//            print("Btn index: \(index)")
//        }
    }
}
