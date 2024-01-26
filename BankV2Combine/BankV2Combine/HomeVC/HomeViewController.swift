//
//  HomeViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView = UIScrollView()
    private lazy var banlanceView = BalanceView(frame: view.frame)
    private let btnCollectionView = BtnCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let favoriteCollectionView = FavoriteCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private lazy var bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
    private lazy var bellBtn: UIButton = {
        let btn = UIButton(frame: CGRectMake(0,0,36,36))
        btn.setImage(UIImage(named: "bellNormal"), for: .normal)
        btn.addTarget(self, action: #selector(bellPressed), for: .touchUpInside)
        return btn
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        layout()
        setupScrollView()
        setupBtnCollectionView()
        setupFavoriteCollectionView()
        bind()
    }
    
    private func bind() {
        
        viewModel.$balanceResult
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                self.banlanceView.configure(result: result)
                self.scrollView.refreshControl?.endRefreshing()
            }.store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showAlert(title: error.description, message: "Please try again.")
                }
            }.store(in: &cancellables)
        
        viewModel.$urls
            .receive(on: DispatchQueue.main)
            .sink { [weak self] urls in
                self?.bannerView.configure(urls: urls)
            }.store(in: &cancellables)
        
        viewModel.$balanceLoadingCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.banlanceView.stopLoadingAnimaiton()
                } else {
                    self?.banlanceView.loadingAnimation()
                }
            }.store(in: &cancellables)
        
        viewModel.$favoriteLoadingCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.favoriteCollectionView.restoreBackgroundView()
                    self?.favoriteCollectionView.reloadData()
                }
            }.store(in: &cancellables)

        viewModel.$messageLoadingCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.bellBtn.setImage(UIImage(named: "bellActive"), for: .normal)
                }
            }.store(in: &cancellables)
        
        viewModel.$adLoadingCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.bannerView.startTimer()
                }
            }.store(in: &cancellables)
    }
    
    private func setupNavBar() {
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle", withConfiguration: config)!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bellBtn)
        navigationItem.backButtonTitle = ""
        
    }
    
    private func setupScrollView() {
        
        scrollView.backgroundColor = ThemeColor.background
        let contentSizeHeight = (view.bounds.height - bannerView.frame.maxY) > 100 ? bannerView.frame.maxY : bannerView.frame.maxY + 100
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentSizeHeight)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func bellPressed(_ sender: UIButton) {
        let messageTableVC = MessageTableViewController(viewModel: MessageListViewModel(messages: viewModel.messages))
        navigationController?.pushViewController(messageTableVC, animated: true)
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        
        viewModel.refresh()
        
    }
    
    private func setupBtnCollectionView() {
        
        btnCollectionView.delegate = self
        btnCollectionView.dataSource = self

    }
    
    private func setupFavoriteCollectionView() {
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true)
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            favoriteCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            bannerView.topAnchor.constraint(equalToSystemSpacingBelow: favoriteCollectionView.bottomAnchor, multiplier: 1),
            bannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bannerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
        view.layoutIfNeeded()
    }

}

//MARK: - Collection view
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView === btnCollectionView ? 6 : viewModel.favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView === btnCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BtnCollectionViewCell.reusedId, for: indexPath) as! BtnCollectionViewCell
            cell.configure(index: indexPath.item)
            return cell
        } else {
            
            let item = viewModel.favoriteItems[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.reusedId, for: indexPath) as! FavoriteCollectionViewCell
            cell.configure(item: item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reusedId, for: indexPath) as! HeaderView
        return headerView
    }
}
