//
//  MessageTableViewCell.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/25.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    static let reusedId = "MessageCell"
    static let rowHeight: CGFloat = 128
    private let titleLabel: UILabel = {
        LabelFactory.build(text: "", font: ThemeFont.bold(ofSize: 18), textColor: ThemeColor.text, textAlignment: .left)
    }()
    
    private let subtitleLabel: UILabel = {
        LabelFactory.build(text: "", font: ThemeFont.regular(ofSize: 14), textColor: ThemeColor.text, textAlignment: .left)
    }()
    
    private let messageLabel: UILabel = {
        let label = LabelFactory.build(text: "", font: ThemeFont.regular(ofSize: 16), textColor: ThemeColor.header, textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.orange
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            messageLabel
        ])
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        backgroundColor = ThemeColor.background
    }
    
    private func layout() {
        [dotView, vStackView].forEach(addSubview(_:))
        dotView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dotView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            dotView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            dotView.widthAnchor.constraint(equalToConstant: 12),
            dotView.heightAnchor.constraint(equalToConstant: 12),
            
            vStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            vStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: dotView.trailingAnchor, multiplier: 0.5),
            trailingAnchor.constraint(equalToSystemSpacingAfter: vStackView.trailingAnchor, multiplier: 4),
            bottomAnchor.constraint(equalToSystemSpacingBelow: vStackView.bottomAnchor, multiplier: 2)
        ])
    }
    
    func configure(message: Message) {
        titleLabel.text = message.title
        subtitleLabel.text = message.updateDateTime
        messageLabel.text = message.message
        dotView.isHidden = message.status
    }
    

}
