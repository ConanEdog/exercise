//
//  UIControl + Extension.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/26.
//

import UIKit
import Combine

extension UIPageControl {
    
    var pageChangedPublisher: AnyPublisher<Int, Never> {
        controlEventPublisher(for: .valueChanged).map { _ in
            self.currentPage
        }.eraseToAnyPublisher()
    }
}
