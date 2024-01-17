//
//  PasswordTextFieldView.swift
//  PasswordCombine
//
//  Created by 方奎元 on 2024/1/17.
//

import UIKit
import Combine
import CombineCocoa


class PasswordTextFieldView: UIView {
    // A function one passes in to do custom validation on the textfield
    // Return a Bool indicating whether text is valid, and if not a String containing an error message
   
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText: String
    let eyeButton = UIButton(type: .custom)
    let didviderView = UIView()
    let errorLabel = UILabel()
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    //Combine
    private let passwordSubject: CurrentValueSubject<String, Never> = .init("")
    var valuePublisher: AnyPublisher<String, Never> {
        return passwordSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        // Uninitalized properties need values before calling super
        super.init(frame: .zero)
        
        style()
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false
        //textField.placeholder = placeHolderText
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        didviderView.translatesAutoresizingMaskIntoConstraints = false
        didviderView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.text = "Enter your password aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa sdfd fdfe ferr"
//        errorLabel.adjustsFontSizeToFitWidth = true
//        errorLabel.minimumScaleFactor = 0.8
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
    }
    
    func layout() {
        [lockImageView, textField, eyeButton, didviderView, errorLabel].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
            
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            didviderView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            didviderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            didviderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            didviderView.heightAnchor.constraint(equalToConstant: 1),
            
            errorLabel.topAnchor.constraint(equalTo: didviderView.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // CHCR (Content-Hugging Compression-Resistance)
        lockImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            self.passwordSubject.send(text ?? "")
        }.store(in: &cancellables)
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
}



//MARK: - Validation

extension PasswordTextFieldView {
    
    func updateErrorLabel(_ result: Result) {
        if !result.validate {
            showError(result.message)
            return
        }
        clearError()
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
}
