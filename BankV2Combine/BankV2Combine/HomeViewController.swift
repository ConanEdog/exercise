//
//  HomeViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
    }
    
    private func setupNavBar() {
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle", withConfiguration: config)!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)
        
    }

}
