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
    
    private lazy var defaultView: DownloadImageView = {
        let view = DownloadImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        self.layer.cornerRadius = 15
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        layout()
    }
    
    private func layout() {
        defaultView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            defaultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            defaultView.centerYAnchor.constraint(equalTo: centerYAnchor),
            defaultView.widthAnchor.constraint(equalTo: widthAnchor),
            defaultView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func configScrollView() {
        self.contentSize = CGSize(width: self.bounds.width * CGFloat(imageURLs.count + 2), height: self.bounds.height)
        
        self.contentOffset = imageURLs.isEmpty ? CGPoint(x: 0, y: 0) : CGPoint(x: self.bounds.width, y: 0)
    }
    
    
    private func setupImage() {
        
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
    
    func configure(urls: [URL]) {
        self.imageURLs = urls
    }
}
