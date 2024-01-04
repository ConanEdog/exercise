//
//  PasswordStatusView.swift
//  Password
//
//  Created by 方奎元 on 2024/1/3.
//

import UIKit

class PasswordStatusView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lengthCriteriaView,
            criteriaLabel,
            upperCaseCriteriaView,
            lowerCaseCriteriaView,
            digitCriteriaView,
            specialCharacterCriteriaView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let criteriaLabel = UILabel()
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let upperCaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    
    // Used to determine if we reset criteria back to empty state.
    private var shouldResetCriteria: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        upperCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    
    func layout() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
    }
    
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        
        return attrText
    }
    
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldResetCriteria {
            // Inline validation
            lengthAndNoSpaceMet ? lengthCriteriaView.isCriteriaMet = true : lengthCriteriaView.reset()
            
            uppercaseMet ? upperCaseCriteriaView.isCriteriaMet = true : upperCaseCriteriaView.reset()
            
            lowercaseMet ? lowerCaseCriteriaView.isCriteriaMet = true : lowerCaseCriteriaView.reset()
            
            digitMet ? digitCriteriaView.isCriteriaMet = true : digitCriteriaView.reset()
            
            specialCharacterMet ? specialCharacterCriteriaView.isCriteriaMet = true : specialCharacterCriteriaView.reset()
        }
    }
}
