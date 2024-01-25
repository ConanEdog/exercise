//
//  DownloadImageView.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import UIKit

class DownloadImageView: UIImageView {

    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    private lazy var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        self.backgroundColor = ThemeColor.secondaryBackground
        indicatorView.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height/2)
        button.backgroundColor = ThemeColor.ad
        button.layer.cornerRadius = 8
        button.setTitle("AD", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textColor = .white
        
        indicatorView.color = .darkGray
        self.addSubview(button)
        self.addSubview(indicatorView)
        
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 48),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func prepareIconView() {
        
        

        
    }

    func loadAsync(url: URL) async throws {
        indicatorView.startAnimating()
        self.button.removeFromSuperview()
        let (data, _) = try await URLSession.shared.data(from: url)
        indicatorView.stopAnimating()
        let image = UIImage(data: data)
        self.image = image

    }
}
