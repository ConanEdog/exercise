//
//  HomeViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let banlanceView = BalanceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        layout()
    }
    
    private func setupNavBar() {
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle", withConfiguration: config)!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        
    }
    
    private func layout() {
        view.addSubview(banlanceView)
        banlanceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            banlanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banlanceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            banlanceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            banlanceView.heightAnchor.constraint(equalToConstant: 160),
            
        ])
    }

}
