//
//  HomeViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let banlanceView = BalanceView()
    private let btnCollectionView = BtnCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let favoriteCollectionView = FavoriteCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private lazy var bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        layout()
        setupScrollView()
        setupBtnCollectionView()
        setupFavoriteCollectionView()
    }
    
    private func setupNavBar() {
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle", withConfiguration: config)!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        
    }
    
    private func setupScrollView() {
        
        scrollView.backgroundColor = ThemeColor.background
        print("ScrollView height: \(scrollView.bounds.width)")
        print("View height: \(view.bounds.width)")
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
    }
    
    private func setupBtnCollectionView() {
        
        btnCollectionView.delegate = self
        btnCollectionView.dataSource = self

    }
    
    private func setupFavoriteCollectionView() {
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
    }
    
    private func layout() {
        view.addSubview(scrollView)
        [banlanceView, btnCollectionView, favoriteCollectionView, bannerView].forEach(scrollView.addSubview(_:))
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        banlanceView.translatesAutoresizingMaskIntoConstraints = false
        btnCollectionView.translatesAutoresizingMaskIntoConstraints = false
        favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            banlanceView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            banlanceView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            banlanceView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            banlanceView.heightAnchor.constraint(equalToConstant: 150),
            
            btnCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: banlanceView.bottomAnchor, multiplier: 1),
            btnCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            btnCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            btnCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            favoriteCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: btnCollectionView.bottomAnchor, multiplier: 1),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            favoriteCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            favoriteCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            bannerView.topAnchor.constraint(equalToSystemSpacingBelow: favoriteCollectionView.bottomAnchor, multiplier: 1),
            bannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bannerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }

}

//MARK: - Collection view
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView === btnCollectionView ? 6 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BtnCollectionViewCell.reusedId, for: indexPath) as! BtnCollectionViewCell
        cell.configure(index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reusedId, for: indexPath) as! HeaderView
        return headerView
    }
}
