//
//  ViewController.swift
//  PasswordCombine
//
//  Created by 方奎元 on 2024/1/17.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {

    let newPasswordTextField = PasswordTextFieldView(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextFieldView(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        newPasswordTextField,
        statusView,
        confirmPasswordTextField,
        resetButton
       ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let vm = PasswordViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        bind()
        observe()
    }
    
    private func bind() {
        
        let input = PasswordViewModel.Input(newPasswordPublisher: newPasswordTextField.valuePublisher, confirmPasswordPublisher: confirmPasswordTextField.valuePublisher)
        
        let output = vm.transform(input: input)
        
        output.updatePublisher.sink { [unowned self] result in
            self.statusView.updateDisplay(result.text)
            self.newPasswordTextField.updateErrorLabel(result)
            self.vm.newPasswordValidate = result.validate
        }.store(in: &cancellables)
        
        output.resultPublisher.sink { [unowned self] result in
            self.confirmPasswordTextField.updateErrorLabel(result)
            self.vm.confirmPasswordValidate = result.validate
        }.store(in: &cancellables)
    }
    
    private func observe() {
        
        viewTapPublisher.sink { [unowned self] () in
            view.endEditing(true)
        }.store(in: &cancellables)
        
        observeKeyboard()
    }
    
    
    private func observeKeyboard() {
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).compactMap { notification in
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        }.sink { [unowned self] keyboardFrame in
            self.adjustViewFrame(keyboardFrame: keyboardFrame)
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).sink { [unowned self] _ in
            self.view.frame.origin.y = 0
        }.store(in: &cancellables)
        
    }
    
    private func adjustViewFrame(keyboardFrame: CGRect) {
        
        guard let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.origin.y
        
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // if textField bottom is below keyboard top - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    

    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
    
    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        let isValidNewPassword = vm.newPasswordValidate
        let isValidConfirmPassword = vm.confirmPasswordValidate
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
            return
        }
        resetButton.shakeButton()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true)
    }
}


//Preview UIKit
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
}

#Preview {
    ViewControllerRepresentable()
}
