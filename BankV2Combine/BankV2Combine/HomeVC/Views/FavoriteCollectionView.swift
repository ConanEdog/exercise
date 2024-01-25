//
//  FavoriteCollectionView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class FavoriteCollectionView: UICollectionView {

    private lazy var defaultView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.background
        [button, label].forEach(view.addSubview(_:))
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.verticalSet(title: "---", imageName: "person.circle.fill", pointSize: 36)
        return button
    }()
    
    private let label: UILabel = {
        let label = LabelFactory.build(text: "You can add a favorite through the transfer or payment function.", font: ThemeFont.regular(ofSize: 14), textColor: UIColor.separator, textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.reusedId)
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reusedId)
        allowsSelection = true
        collectionViewLayout = generateLayout()
        backgroundView = defaultView
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: defaultView.leadingAnchor, multiplier: 4),
            button.centerYAnchor.constraint(equalTo: defaultView.centerYAnchor, constant: 25),
            
            label.leadingAnchor.constraint(equalTo: button.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -5),
            label.widthAnchor.constraint(equalTo: defaultView.widthAnchor, multiplier: 2/3)
        ])
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func restoreBackgroundView() {
        let view = UIView()
        view.backgroundColor = ThemeColor.background
        backgroundView = view
    }
}
