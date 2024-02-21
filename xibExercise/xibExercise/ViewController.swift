//
//  ViewController.swift
//  xibExercise
//
//  Created by 方奎元 on 2024/2/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var initCoderView: HintTextView!
    
    lazy var nameView: HintTextView = {
        let view = HintTextView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        view.hintLabel.text = "Name"
        view.textField.placeholder = "Enter your name"
        return view
    }()
    lazy var passwordView : HintTextView = {
        let view = HintTextView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        view.hintLabel.text = "Password"
        view.textField.placeholder = "Enter your password"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView() {
        
        [nameView, passwordView].forEach(view.addSubview(_:))
        nameView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameView.trailingAnchor, multiplier: 2),
            passwordView.topAnchor.constraint(equalToSystemSpacingBelow: nameView.bottomAnchor, multiplier: 1),
            passwordView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: nameView.trailingAnchor)
        ])
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

protocol a {
    associatedtype DataModelForCell
}
