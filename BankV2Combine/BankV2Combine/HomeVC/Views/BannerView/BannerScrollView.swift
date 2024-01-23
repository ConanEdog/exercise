//
//  BannerScrollView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class BannerScrollView: UIScrollView {
    
    var imageURLs = [URL]() {
        didSet {
            self.configScrollView()
            self.setupImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        let imageView = DownloadImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.addSubview(imageView)
        self.layer.cornerRadius = 15
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true

    }
    
    func configScrollView() {
        self.contentSize = CGSize(width: self.bounds.width * CGFloat(imageURLs.count + 2), height: self.bounds.height)
        self.contentOffset = CGPoint(x: self.bounds.width, y: 0)
    }
    
    
    func setupImage() {
        
        guard imageURLs.isEmpty == false else {
            return
        }
        for i in 0...(imageURLs.count + 1) {
            
            let imageView = DownloadImageView(frame: CGRect(x: self.frame.width * CGFloat(i), y: 0, width: self.bounds.width, height: self.bounds.height))
            var url: URL
            
            switch i {
                
            case 0:
                url = imageURLs.last!
            case imageURLs.count + 1:
                url = imageURLs.first!
            default:
                url = imageURLs[i - 1]
            }
            Task {
                try? await imageView.loadAsync(url: url)
            }
            self.addSubview(imageView)
        }
    }
}
