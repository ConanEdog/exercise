//
//  tabView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/22.
//

import UIKit
import Combine
import CombineCocoa

class TabView: UIView {
    
    private lazy var homeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.verticalSet(title: "Home", imageName: "house", pointSize: 20)
        button.tapPublisher.flatMap {
            Just(Tab.home)
        }.assign(to: \.value, on: tabSubject).store(in: &cancellables)
        return button
    }()
    
    private lazy var accountBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.verticalSet(title: "Account", imageName: "list.dash.header.rectangle", pointSize: 20)
        button.tapPublisher.flatMap {
            Just(Tab.account)
        }.assign(to: \.value, on: tabSubject).store(in: &cancellables)
        return button
    }()
    
    private lazy var locationBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.verticalSet(title: "Location", imageName: "mappin.and.ellipse", pointSize: 20)
        button.tapPublisher.flatMap {
            Just(Tab.location)
        }.assign(to: \.value, on: tabSubject).store(in: &cancellables)
        return button
    }()
    
    private lazy var serviceBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.verticalSet(title: "Service", imageName: "person.2.fill", pointSize: 20)
        button.tapPublisher.flatMap {
            Just(Tab.service)
        }.assign(to: \.value, on: tabSubject).store(in: &cancellables)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [
        homeBtn,
        accountBtn,
        locationBtn,
        serviceBtn
       ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 4
        return view
    }()
    
    private let tabSubject: CurrentValueSubject<Tab, Never> = .init(Tab.home)
    var valuePublisher : AnyPublisher<Tab, Never> {
        return tabSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        style()
        obersve()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            hStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: hStackView.bottomAnchor, multiplier: 1),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: hStackView.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func style() {
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowOpacity = 0.3
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        backgroundColor = .white
    }
    
    private func obersve() {
        tabSubject.sink { [unowned self] tab in
            reset()
            
            switch tab {
            case .home:
                homeBtn.tintColor = ThemeColor.primary
            case .account:
                accountBtn.tintColor = ThemeColor.primary
            case .location:
                locationBtn.tintColor = ThemeColor.primary
            case .service:
                serviceBtn.tintColor = ThemeColor.primary
            }
        }.store(in: &cancellables)
    }
    
    private func reset() {
        [homeBtn, accountBtn, locationBtn, serviceBtn].forEach {
            $0.tintColor = .systemGray2
        }
    }
}
