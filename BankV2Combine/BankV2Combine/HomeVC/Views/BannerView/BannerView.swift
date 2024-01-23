//
//  BannerView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class BannerView: UIView {

    private lazy var scrollView = BannerScrollView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .black
        control.numberOfPages = scrollView.imageURLs.count
        control.currentPage = 0
        control.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [scrollView, pageControl].forEach(addSubview(_:))
        
        scrollView.delegate = self
        layout()
    }
    
    private func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 2),
            scrollView.heightAnchor.constraint(equalToConstant: 130),
            
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 12)
            
            
        ])
    }
    
    @objc private func pageChanged() {
        
    }
}

extension BannerView: UIScrollViewDelegate {
    
}
