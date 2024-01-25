//
//  ViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit
import SwiftUI
import Combine

class ContainerVC: UIViewController {

    let tabView = TabView()
    
    let homeNav = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel(webService: Webservice())))
    let accountNaV = UINavigationController(rootViewController: AccountViewController())
    let locationNaV = UINavigationController(rootViewController: LocationViewController())
    let serviceNaV = UINavigationController(rootViewController: ServiceViewController())
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }

    
    
    private func layout() {
        
        view.addSubview(tabView)
        tabView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tabView.bottomAnchor, multiplier: 6),
            tabView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tabView.trailingAnchor, multiplier: 2),
            tabView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupChildVC(_ controller: UIViewController) {
        //remove previous childVC
        children.forEach(remove(_:))
        
        // add selected childVC
        controller.didMove(toParent: self)
        addChild(controller)
        view.addSubview(controller.view)
        view.bringSubviewToFront(tabView)
    }
    
    private func remove(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    private func bind() {
        
        tabView.valuePublisher.sink { [unowned self] tab in
            switch tab {
                
            case .home:
                setupChildVC(homeNav)
            case .account:
                setupChildVC(accountNaV)
            case .location:
                setupChildVC(locationNaV)
            case .service:
                setupChildVC(serviceNaV)
            }
        }.store(in: &cancellables)
        
    }
    
    func hideTabView() {
        tabView.isHidden = true
    }
    
    func showTabView() {
        tabView.isHidden = false
    }

}

//Preview UIKit
struct ViewControllerRepresentable:
    UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        ContainerVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

#Preview {
    ViewControllerRepresentable()
}

