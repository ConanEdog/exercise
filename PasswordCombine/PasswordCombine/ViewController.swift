//
//  ViewController.swift
//  PasswordCombine
//
//  Created by 方奎元 on 2024/1/17.
//

import UIKit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
