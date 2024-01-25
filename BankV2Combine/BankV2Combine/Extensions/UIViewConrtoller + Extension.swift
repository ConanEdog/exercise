//
//  UIViewConrtoller + Extension.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/25.
//

import UIKit

extension UIViewController {
    
    func hideTabBar() {
        if let parent = navigationController?.parent as? ContainerVC {
            parent.hideTabView()
        }
    }
    
    func showTabBar() {
        if let parent = navigationController?.parent as? ContainerVC {
            parent.showTabView()
        }
    }
}
