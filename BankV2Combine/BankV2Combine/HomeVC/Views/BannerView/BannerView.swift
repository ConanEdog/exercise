//
//  BannerView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit
import Combine
import CombineCocoa

class BannerView: UIView {

    private lazy var scrollView = BannerScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .black
        control.numberOfPages = scrollView.imageURLs.count
        return control
    }()
    
    @Published var pageIndex: Int = 1
    
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [scrollView, pageControl].forEach(addSubview(_:))
        scrollView.isScrollEnabled = false
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
            scrollView.heightAnchor.constraint(equalToConstant: 120),
            
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 12)
        
        ])
    }
    
    func configure(urls: [URL]) {
        observe()
        scrollView.configure(urls: urls)
        pageControl.numberOfPages = scrollView.imageURLs.count
    }
    
    private func observe() {
        
        scrollView.contentOffsetPublisher
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .map{$0.x}
            .sink { [unowned self] offSetX in
                
                if offSetX == 0 {
                    let contentOffsetMinX = self.scrollView.bounds.width * CGFloat(self.scrollView.imageURLs.count)
                    scrollView.contentOffset = CGPoint(x: contentOffsetMinX, y: 0)
                }
                
                if offSetX == self.scrollView.bounds.width * CGFloat(self.scrollView.imageURLs.count + 1) {
                    scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
                }
                
                let page = round(offSetX/scrollView.bounds.width) - 1
                pageControl.currentPage = Int(page)
                pageIndex = Int(page) + 1
            }.store(in: &cancellables)
        
        pageControl.pageChangedPublisher.sink { [unowned self] page in
            stopTimer()
            let contentOffSetMinX = self.scrollView.bounds.width * CGFloat(page + 1)
            let point = CGPoint(x: contentOffSetMinX, y: 0)
            self.scrollView.setContentOffset(point, animated: true)
            pageIndex = Int(contentOffSetMinX / self.scrollView.bounds.width)
            startTimer()
        }.store(in: &cancellables)
    }
    
    func startTimer() {
        scrollView.isScrollEnabled = true
        scrollView.removeDefaultView()
        timerCancellable = Timer.publish(every: 3.0, on: .main, in: .default)
            .autoconnect()
            .sink { [unowned self] time in
                
                if pageIndex == self.scrollView.imageURLs.count + 1 {
                    pageIndex = 2
                } else {
                    pageIndex += 1
                }
                
                
                scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(pageIndex), y: 0), animated: true)
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
}

extension BannerView: UIScrollViewDelegate {
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}
